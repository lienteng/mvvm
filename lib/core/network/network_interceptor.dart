// import 'package:dio/dio.dart';
// import 'package:mvvm/core/services/storage_service.dart';
// import '../errors/exceptions.dart';

// class NetworkInterceptor extends Interceptor {
//   @override
//   Future<void> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     final connectivityResult = await Connectivity().checkConnectivity();
//     if (!connectivityResult.contains(ConnectivityResult.mobile) &&
//         !connectivityResult.contains(ConnectivityResult.wifi)) {
//       handler.reject(
//         DioException(
//           requestOptions: options,
//           type: DioExceptionType.connectionError,
//           error: NoInternetException('No internet connection'),
//         ),
//       );
//       return;
//     }

//     final token = StorageService.getString(AppConstants.userTokenKey);
//     if (token != null && token.isNotEmpty) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }

//     options.headers['X-Device-Platform'] = 'Flutter';
//     options.headers['X-App-Version'] = AppConstants.appVersion;
//     options.headers['Accept'] = 'application/json';
//     options.headers['Content-Type'] = 'application/json; charset=UTF-8';

//     handler.next(options);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     handler.next(response);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     late AppException exception;

//     switch (err.type) {
//       case DioExceptionType.connectionTimeout:
//       case DioExceptionType.sendTimeout:
//       case DioExceptionType.receiveTimeout:
//         exception = TimeoutException('Request timeout: ${err.message}');
//         break;

//       case DioExceptionType.badResponse:
//         exception = ServerException(
//           'HTTP error: ${err.response?.statusCode} - ${err.response?.data?['message'] ?? 'No message'}',
//         );
//         break;

//       case DioExceptionType.cancel:
//         exception = RequestCancelledException('Request cancelled');
//         break;

//       case DioExceptionType.connectionError:
//         exception = NoInternetException(
//           'No internet connection, please check your internet connection',
//         );
//         break;

//       case DioExceptionType.badCertificate:
//         exception = ServerException('SSL certificate error: ${err.message}');
//         break;

//       case DioExceptionType.unknown:
//         if (err.message?.contains('SocketException') == true ||
//             err.message?.contains('Connection refused') == true) {
//           exception = NoInternetException(
//             'Connection refused: ${err.message ?? 'Server unreachable'}',
//           );
//         } else {
//           exception = UnknownException(
//             'Unknown error: ${err.message ?? 'No response from server'}',
//           );
//         }
//         break;
//     }

//     // return wrapped exception
//     handler.reject(
//       DioException(
//         requestOptions: err.requestOptions,
//         type: err.type,
//         error: exception,
//         response: err.response,
//       ),
//     );
//   }
// }
