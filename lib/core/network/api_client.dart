// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import '../constants/api_constants.dart';
// import 'network_interceptor.dart';

// class ApiClient {
//   static ApiClient? _instance;
//   late Dio _dio;

//   ApiClient._internal() {
//     _dio = Dio();
//     _setupDio();
//   }

//   static ApiClient get instance {
//     _instance ??= ApiClient._internal();
//     return _instance!;
//   }

//   void _setupDio() {
//     _dio.options = BaseOptions(
//       baseUrl: ApiConstants.baseUrl,
//       connectTimeout: const Duration(seconds: 30),
//       receiveTimeout: const Duration(seconds: 30),
//       sendTimeout: const Duration(seconds: 30),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Accept': 'application/json',
//         'X-Device-Platform': 'Flutter',
//         'X-App-Version': '1.0.0',
//       },
//       responseType: ResponseType.json,
//       receiveDataWhenStatusError: true,
//       followRedirects: true,
//       validateStatus: (_) => true,
//     );

//     // // เพิ่ม Interceptor แบบกำหนดเอง (NetworkInterceptor) เข้าไปใน Dio เพื่อดักจับ / ดัดแปลง request หรือ response ก่อนจะถูกส่งหรือรับในแอป แล้วมันจะ check status code อีกที เพื่อดักจับ error
//     _dio.interceptors.add(NetworkInterceptor());

//     // Add pretty logger for debugging
//     _dio.interceptors.add(
//       PrettyDioLogger(
//         requestHeader: true,
//         requestBody: true,
//         responseBody: true,
//         responseHeader: false,
//         error: true,
//         compact: true,
//         maxWidth: 90,
//         logPrint: (object) => print(object),
//       ),
//     );
//   }

//   // GET request
//   Future<Response> get(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.get(
//         path,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );

//       return response;
//     } catch (e) {
//       debugPrint('❌ ApiClient GET error: $e');

//       rethrow;
//     }
//   }

//   // POST request
//   Future<Response> post(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.post(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );
//       return response;
//     } catch (e) {
//       debugPrint('❌ ApiClient POST error: $e');
//       rethrow;
//     }
//   }

//   // PUT request
//   Future<Response> put(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.put(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );

//       return response;
//     } catch (e) {
//       debugPrint('❌ ApiClient PUT error: $e');

//       rethrow;
//     }
//   }

//   // DELETE request
//   Future<Response> delete(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.delete(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );

//       return response;
//     } catch (e) {
//       debugPrint('❌ ApiClient DELETE error: $e');

//       rethrow;
//     }
//   }

//   // Upload file
//   Future<Response> uploadFile(
//     String path,
//     String filePath, {
//     String? fileName,
//     Map<String, dynamic>? data,
//     ProgressCallback? onSendProgress,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final formData = FormData();

//       // Add file
//       formData.files.add(
//         MapEntry(
//           'file',
//           await MultipartFile.fromFile(filePath, filename: fileName),
//         ),
//       );

//       // Add additional data
//       if (data != null) {
//         data.forEach((key, value) {
//           formData.fields.add(MapEntry(key, value.toString()));
//         });
//       }

//       final response = await _dio.post(
//         path,
//         data: formData,
//         onSendProgress: onSendProgress,
//         cancelToken: cancelToken,
//       );

//       return response;
//     } catch (e) {
//       debugPrint('❌ ApiClient upload error: $e');

//       rethrow;
//     }
//   }

//   // Download file
//   Future<Response> downloadFile(
//     String url,
//     String savePath, {
//     ProgressCallback? onReceiveProgress,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.download(
//         url,
//         savePath,
//         onReceiveProgress: onReceiveProgress,
//         cancelToken: cancelToken,
//       );

//       return response;
//     } catch (e) {
//       debugPrint('❌ ApiClient download error: $e');
//       rethrow;
//     }
//   }

//   // Update token
//   void updateToken(String token) {
//     _dio.options.headers['Authorization'] = 'Bearer $token';
//   }

//   // Remove token
//   void removeToken() {
//     _dio.options.headers.remove('Authorization');
//   }

//   // Get current Dio instance (for advanced usage)
//   Dio get dio => _dio;
// }
