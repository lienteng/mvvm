import 'package:dio/dio.dart';
import 'package:mvvm/features/auth/models/login_response.dart';
import '../constants/api_constants.dart';
import 'storage_service.dart';
import '../di/service_locator.dart';
import '../models/api_response.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.options.followRedirects = true;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add token to requests (except auth endpoints)
          if (!_isAuthEndpoint(options.path)) {
            final storageService = ServiceLocator.get<StorageService>();
            final token = storageService.getString(ApiConstants.accessTokenKey);
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }

          print('REQUEST: ${options.method} ${options.path}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          print(
            'RESPONSE: ${response.statusCode} ${response.requestOptions.path}',
          );
          handler.next(response);
        },
        onError: (error, handler) async {
          print('ERROR: ${error.message}');

          // Handle token refresh on 401 errors
          if (error.response?.statusCode == 401 &&
              !_isAuthEndpoint(error.requestOptions.path)) {
            try {
              // Try to refresh token
              final storageService = ServiceLocator.get<StorageService>();
              final refreshToken = storageService.getString(
                ApiConstants.refreshTokenKey,
              );

              if (refreshToken != null) {
                final refreshResponse = await _dio.post(
                  ApiConstants.refreshToken,
                  data: {'refresh_token': refreshToken},
                );

                if (refreshResponse.statusCode == 200) {
                  final newToken = refreshResponse.data['token'];
                  await storageService.setString(
                    ApiConstants.accessTokenKey,
                    newToken,
                  );

                  // Retry original request with new token
                  error.requestOptions.headers['Authorization'] =
                      'Bearer $newToken';
                  final retryResponse = await _dio.fetch(error.requestOptions);
                  handler.resolve(retryResponse);
                  return;
                }
              }
            } catch (e) {
              print('Token refresh failed: $e');
            }
          }

          handler.next(error);
        },
      ),
    );
  }

  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);

      return ApiResponse.fromJson(response.data, fromJson);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return ApiResponse.fromJson(response.data, fromJson);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Auth-specific methods that don't require token
  Future<T> postAuth<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      if (T == LoginResponse) {
        return fromJson(response.data);
      } else {
        return fromJson(response.data);
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout');
      case DioExceptionType.badResponse:
        return Exception('Server error: ${error.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      default:
        return Exception('Network error: ${error.message}');
    }
  }

  bool _isAuthEndpoint(String path) {
    return path.contains('/auth/') ||
        path == ApiConstants.login ||
        path == ApiConstants.logout ||
        path == ApiConstants.refreshToken;
  }
}
