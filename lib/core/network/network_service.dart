// import 'package:dio/dio.dart';
// import 'api_client.dart';
// import 'api_response.dart';
// import '../errors/exceptions.dart';

// class NetworkService {
//   static final ApiClient _apiClient = ApiClient.instance;

//   // Generic GET request
//   static Future<ApiResponse<T>> get<T>(
//     String endpoint, {
//     Map<String, dynamic>? queryParameters,
//     T Function(dynamic)? fromJson,
//   }) async {
//     try {
//       final response = await _apiClient.get(
//         endpoint,
//         queryParameters: queryParameters,
//       );
//       if (response.statusCode != 200) {
//         _handleHttpError(response.statusCode, response.data);
//       }

//       final apiResponse = ApiResponse.fromJson(response.data, fromJson);

//       if (apiResponse.isError) {
//         throw ServerException(apiResponse.errorMessage);
//       }

//       return apiResponse;
//     } on DioException catch (e) {
//       throw _handleDioException(e);
//     } catch (e) {
//       throw UnknownException('Unexpected error: $e');
//     }
//   }

//   // Generic POST request
//   static Future<ApiLoginResponse<T>> post<T>(
//     String endpoint, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     T Function(dynamic)? fromJson,
//   }) async {
//     try {
//       final response = await _apiClient.post(
//         endpoint,
//         data: data,
//         queryParameters: queryParameters,
//       );

//       if (response.statusCode != 200) {
//         _handleHttpError(response.statusCode, response.data);
//       }

//       if (response.data is String &&
//           response.data.toString().contains('<html')) {
//         throw ServerException('ບໍ່ພົບເສັ້ນທາງ API ທີ່ລະບຸ.');
//       }

//       final apiResponse = ApiLoginResponse.fromJson(response.data, fromJson);

//       if (AppResCode.isError(apiResponse.resCode)) {
//         if (apiResponse.resCode == AppResCode.tokenExpired) {
//           final newToken = await _refreshToken();
//           _apiClient.updateToken(newToken);
//           final retryResponse = await _apiClient.post(
//             endpoint,
//             data: data,
//             queryParameters: queryParameters,
//           );
//           return ApiLoginResponse.fromJson(retryResponse.data, fromJson);
//         }
//         _handleApiError(apiResponse.resCode, apiResponse.message);
//       }

//       return apiResponse;
//     } on DioException catch (e) {
//       throw _handleDioException(e);
//     } catch (e) {
//       if (e is AppException) {
//         rethrow;
//       }
//       throw UnknownException('Unexpected error: $e');
//     }
//   }

//   static Future<String> _refreshToken() async {
//     try {
//       final refreshToken = StorageService.getString(
//         AppConstants.refreshTokenKey,
//       );
//       if (refreshToken == null || refreshToken.isEmpty) {
//         throw UnauthorizedException('No refresh token available');
//       }

//       final response = await _apiClient.post(
//         ApiConstants.refreshToken,
//         data: {'refreshToken': refreshToken},
//       );

//       if (response.statusCode != 200) {
//         _handleHttpError(response.statusCode, response.data);
//       }

//       final apiResponse = ApiResponse.fromJson(
//         response.data,
//         null,
//       ); // Error: Missing fromJsonT argument

//       if (AppResCode.isError(apiResponse.resCode)) {
//         if (apiResponse.resCode == AppResCode.refreshTokenExpired) {
//           _handleApiError(apiResponse.resCode, apiResponse.message);
//         }
//       }

//       final newToken =
//           apiResponse.data as String; // Error: apiResponse.data is null or Map
//       StorageService.setString(AppConstants.userTokenKey, newToken);

//       return newToken;
//     } catch (e) {
//       print('❌ Refresh Token Failed: $e');
//       rethrow;
//     }
//   }

//   // Generic PUT request
//   static Future<ApiResponse<T>> put<T>(
//     String endpoint, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     T Function(dynamic)? fromJson,
//   }) async {
//     try {
//       final response = await _apiClient.put(
//         endpoint,
//         data: data,
//         queryParameters: queryParameters,
//       );

//       if (response.statusCode != 200) {
//         _handleHttpError(response.statusCode, response.data);
//       }

//       final apiResponse = ApiResponse.fromJson(response.data, fromJson);

//       if (apiResponse.isError) {
//         throw ServerException(apiResponse.errorMessage);
//       }

//       return apiResponse;
//     } on DioException catch (e) {
//       throw _handleDioException(e);
//     } catch (e) {
//       throw UnknownException('Unexpected error: $e');
//     }
//   }

//   // Generic DELETE request
//   static Future<ApiResponse<T>> delete<T>(
//     String endpoint, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     T Function(dynamic)? fromJson,
//   }) async {
//     try {
//       final response = await _apiClient.delete(
//         endpoint,
//         data: data,
//         queryParameters: queryParameters,
//       );

//       if (response.statusCode != 200) {
//         _handleHttpError(response.statusCode, response.data);
//       }

//       final apiResponse = ApiResponse.fromJson(response.data, fromJson);

//       if (apiResponse.isError) {
//         throw ServerException(apiResponse.errorMessage);
//       }

//       return apiResponse;
//     } on DioException catch (e) {
//       throw _handleDioException(e);
//     } catch (e) {
//       throw UnknownException('Unexpected error: $e');
//     }
//   }

//   // Enhanced paginated GET request for lists with flexible pagination
//   static Future<PaginatedApiResponse<T>> getList<T>(
//     String endpoint, {
//     Map<String, dynamic>? queryParameters,
//     required T Function(Map<String, dynamic>) fromJson,
//   }) async {
//     try {
//       final response = await _apiClient.get(
//         endpoint,
//         queryParameters: queryParameters,
//       );

//       if (response.statusCode != 200) {
//         _handleHttpError(response.statusCode, response.data);
//       }

//       final apiResponse = PaginatedApiResponse.fromJson(
//         response.data,
//         fromJson,
//       );

//       if (apiResponse.isError) {
//         throw ServerException(apiResponse.errorMessage);
//       }

//       return apiResponse;
//     } on DioException catch (e) {
//       throw _handleDioException(e);
//     } catch (e) {
//       throw UnknownException('Unexpected error: $e');
//     }
//   }

//   // Flexible API response handler that can handle different data formats
//   static Future<FlexibleApiResponse> getFlexible<T>(
//     String endpoint, {
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     try {
//       final response = await _apiClient.get(
//         endpoint,
//         queryParameters: queryParameters,
//       );

//       if (response.statusCode != 200) {
//         _handleHttpError(response.statusCode, response.data);
//       }

//       final apiResponse = FlexibleApiResponse.fromJson(response.data);

//       if (apiResponse.isError) {
//         throw ServerException(apiResponse.errorMessage);
//       }

//       return apiResponse;
//     } on DioException catch (e) {
//       throw _handleDioException(e);
//     } catch (e) {
//       throw UnknownException('Unexpected error: $e');
//     }
//   }

//   // Specialized methods for your API formats
//   static Future<BannerResponse> getBanner(String endpoint) async {
//     try {
//       final response = await _apiClient.get(endpoint);
//       final bannerResponse = BannerResponse.fromJson(response.data);

//       if (bannerResponse.isError) {
//         throw ServerException(bannerResponse.errorMessage);
//       }

//       return bannerResponse;
//     } on DioException catch (e) {
//       throw _handleDioException(e);
//     } catch (e) {
//       throw UnknownException('Unexpected error: $e');
//     }
//   }

//   static Future<AppConfigResponse> getAppConfig(String endpoint) async {
//     try {
//       final response = await _apiClient.get(endpoint);
//       final configResponse = AppConfigResponse.fromJson(response.data);

//       if (configResponse.isError) {
//         throw ServerException(configResponse.errorMessage);
//       }

//       return configResponse;
//     } on DioException catch (e) {
//       throw _handleDioException(e);
//     } catch (e) {
//       throw UnknownException('Unexpected error: $e');
//     }
//   }

//   // Upload file
//   static Future<ApiResponse<T>> uploadFile<T>(
//     String endpoint,
//     String filePath, {
//     String? fileName,
//     Map<String, dynamic>? data,
//     ProgressCallback? onProgress,
//     T Function(dynamic)? fromJson,
//   }) async {
//     try {
//       final response = await _apiClient.uploadFile(
//         endpoint,
//         filePath,
//         fileName: fileName,
//         data: data,
//         onSendProgress: onProgress,
//       );

//       final apiResponse = ApiResponse.fromJson(response.data, fromJson);

//       if (apiResponse.isError) {
//         throw ServerException(apiResponse.errorMessage);
//       }

//       return apiResponse;
//     } on DioException catch (e) {
//       throw _handleDioException(e);
//     } catch (e) {
//       throw UnknownException('Unexpected error: $e');
//     }
//   }

//   // Download file
//   static Future<void> downloadFile(
//     String url,
//     String savePath, {
//     ProgressCallback? onProgress,
//   }) async {
//     try {
//       await _apiClient.downloadFile(
//         url,
//         savePath,
//         onReceiveProgress: onProgress,
//       );
//     } on DioException catch (e) {
//       throw _handleDioException(e);
//     } catch (e) {
//       throw UnknownException('Unexpected error: $e');
//     }
//   }

//   static Exception _handleDioException(DioException e) {
//     switch (e.type) {
//       case DioExceptionType.connectionTimeout:
//       case DioExceptionType.sendTimeout:
//       case DioExceptionType.receiveTimeout:
//         return TimeoutException('Request timeout: ${e.message}');

//       case DioExceptionType.badResponse:
//         return ServerException(
//           'HTTP error: ${e.response?.statusCode} - ${e.response?.data?['message'] ?? 'No message'}',
//         );

//       case DioExceptionType.cancel:
//         return RequestCancelledException('Request cancelled');

//       case DioExceptionType.connectionError:
//         return NoInternetException(
//           'No internet connection, please check your internet connection',
//         );

//       case DioExceptionType.badCertificate:
//         return ServerException('SSL certificate error: ${e.message}');

//       case DioExceptionType.unknown:
//         if (e.message?.contains('SocketException') == true ||
//             e.message?.contains('Connection refused') == true) {
//           return NoInternetException(
//             'Connection refused: ${e.message ?? 'Server unreachable'}',
//           );
//         }
//         return UnknownException(
//           'Unknown error: ${e.message ?? 'No response from server'}',
//         );
//     }
//   }

//   // Update auth token
//   static void updateToken(String token) {
//     _apiClient.updateToken(token);
//   }

//   // Remove auth token
//   static void removeToken() {
//     _apiClient.removeToken();
//   }

//   static void _handleApiError(String resCode, String message) {
//     switch (resCode) {
//       case AppResCode.unauthorized:
//       case AppResCode.tokenExpired:
//       case AppResCode.refreshTokenExpired:
//         _handleUnauthorized();
//         throw UnauthorizedException(AppResCode.getErrorMessage(resCode));

//       case AppResCode.badRequest:
//         throw BadRequestException(AppResCode.getErrorMessage(resCode));

//       case AppResCode.notFound:
//         throw NotFoundException(AppResCode.getErrorMessage(resCode));

//       case AppResCode.validationFailed:
//         throw ValidationException(AppResCode.getErrorMessage(resCode));

//       case AppResCode.noPermission:
//         throw ForbiddenException(AppResCode.getErrorMessage(resCode));

//       case AppResCode.internalServerError:
//       case AppResCode.serviceUnavailable:
//         throw ServerException(AppResCode.getErrorMessage(resCode));

//       case AppResCode.invalidCredentials:
//         throw UnauthorizedException(AppResCode.getErrorMessage(resCode));

//       case AppResCode.userNotActive:
//         throw ForbiddenException(AppResCode.getErrorMessage(resCode));

//       default:
//         throw ServerException(AppResCode.getErrorMessage(resCode));
//     }
//   }

//   static void _handleHttpError(int? statusCode, dynamic responseData) {
//     final message = responseData is String
//         ? responseData
//         : responseData['message'];

//     if (message == null) {
//       throw ServerException('Server error: $statusCode');
//     }

//     switch (statusCode) {
//       case 400:
//         throw BadRequestException(message);
//       case 401:
//         _handleUnauthorized();
//         throw UnauthorizedException('Unauthorized access: $message');
//       case 403:
//         throw ForbiddenException('Access forbidden: $message');
//       case 404:
//         throw NotFoundException('ບໍ່ພົບເສັ້ນທາງ API ທີ່ລະບຸ');
//       case 422:
//         throw ValidationException(message);
//       case 500:
//         throw ServerException('Internal server error: $message');
//       case 502:
//         throw ServerException('Bad gateway: $message');
//       case 503:
//         throw ServerException('Service unavailable: $message');
//       default:
//         throw ServerException('Server error: $statusCode - $message');
//     }
//   }

//   static void _handleUnauthorized() {
//     print('🔓 Clearing auth data');
//     StorageService.remove(AppConstants.userTokenKey);
//     StorageService.remove(AppConstants.userDataKey);
//     StorageService.remove(AppConstants.refreshTokenKey);
//   }
// }
