import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../models/app_error.dart';
import '../models/api_response.dart';
import '../utils/app_res_code.dart';
import 'storage_service.dart';
import 'connectivity_service.dart';
import '../di/service_locator.dart';

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
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Check internet connectivity before making request
          final hasInternet = await ConnectivityService.hasInternetConnection();
          if (!hasInternet) {
            handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.connectionError,
                message: 'No internet connection',
              ),
            );
            return;
          }

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

      // Parse the response
      final apiResponse = ApiResponse.fromJson(response.data, fromJson);

      // Check if the response code indicates success
      if (!AppResCode.isSuccess(apiResponse.resCode)) {
        throw AppError.apiResponse(apiResponse.resCode, apiResponse.message);
      }

      return apiResponse;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on AppError {
      rethrow; // Re-throw AppError as is
    } catch (e) {
      throw AppError.unknown('Unexpected error occurred', originalError: e);
    }
  }

  Future<ApiResponse<T>> getDataByBody<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      // Parse the response
      final apiResponse = ApiResponse.fromJson(response.data, fromJson);

      // Check if the response code indicates success
      if (!AppResCode.isSuccess(apiResponse.resCode)) {
        throw AppError.apiResponse(apiResponse.resCode, apiResponse.message);
      }

      return apiResponse;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on AppError {
      rethrow; // Re-throw AppError as is
    } catch (e) {
      throw AppError.unknown('Unexpected error occurred', originalError: e);
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

      // Parse the response
      final apiResponse = ApiResponse.fromJson(response.data, fromJson);

      // Check if the response code indicates success
      if (!AppResCode.isSuccess(apiResponse.resCode)) {
        throw AppError.apiResponse(apiResponse.resCode, apiResponse.message);
      }

      return apiResponse;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on AppError {
      rethrow; // Re-throw AppError as is
    } catch (e) {
      throw AppError.unknown('Unexpected error occurred', originalError: e);
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
      print('ApiService: Making auth request to $path');
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      print('ApiService: Auth response status: ${response.statusCode}');
      print('ApiService: Auth response data: ${response.data}');

      // For LoginResponse, return the parsed response regardless of resCode
      return fromJson(response.data);
    } on DioException catch (e) {
      print('ApiService: DioException in postAuth: ${e.message}');
      print('ApiService: DioException response: ${e.response?.data}');

      // If we have a response with data, try to parse it as a login response
      if (e.response?.data != null) {
        try {
          return fromJson(e.response!.data);
        } catch (parseError) {
          print('ApiService: Failed to parse error response: $parseError');
        }
      }

      throw _handleDioError(e);
    }
  }

  AppError _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppError.timeout('Request timed out. Please try again.');

      case DioExceptionType.connectionError:
        if (error.message?.contains('No internet connection') == true) {
          return AppError.noInternet();
        }
        return AppError.network(
          'Connection failed. Please check your internet connection.',
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        switch (statusCode) {
          case 400:
            return AppError.server(
              statusCode,
              'Bad request. Please check your input.',
            );
          case 401:
            return AppError.unauthorized(
              'Session expired. Please login again.',
            );
          case 403:
            return AppError.server(
              statusCode,
              'Access denied. You don\'t have permission.',
            );
          case 404:
            return AppError.notFound('The requested resource was not found.');
          case 500:
            return AppError.server(
              statusCode,
              'Server error. Please try again later.',
            );
          case 502:
          case 503:
          case 504:
            return AppError.server(
              statusCode,
              'Server is temporarily unavailable.',
            );
          default:
            return AppError.server(
              statusCode,
              'Server error (${statusCode}). Please try again.',
            );
        }

      case DioExceptionType.cancel:
        return AppError.network('Request was cancelled.');

      default:
        return AppError.network('Network error. Please check your connection.');
    }
  }

  bool _isAuthEndpoint(String path) {
    return path.contains('/auth/') ||
        path == ApiConstants.login ||
        path == ApiConstants.logout ||
        path == ApiConstants.refreshToken;
  }
}
