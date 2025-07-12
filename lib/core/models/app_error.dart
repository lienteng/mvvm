enum ErrorType {
  network,
  server,
  timeout,
  unauthorized,
  notFound,
  validation,
  unknown,
  noInternet,
  apiResponse,
}

class AppError {
  final ErrorType type;
  final String message;
  final String? code;
  final int? statusCode;
  final dynamic originalError;

  AppError({
    required this.type,
    required this.message,
    this.code,
    this.statusCode,
    this.originalError,
  });

  factory AppError.network(String message, {dynamic originalError}) {
    return AppError(
      type: ErrorType.network,
      message: message,
      originalError: originalError,
    );
  }

  factory AppError.server(
    int statusCode,
    String message, {
    dynamic originalError,
  }) {
    return AppError(
      type: ErrorType.server,
      message: message,
      statusCode: statusCode,
      originalError: originalError,
    );
  }

  factory AppError.timeout(String message) {
    return AppError(type: ErrorType.timeout, message: message);
  }

  factory AppError.unauthorized(String message) {
    return AppError(type: ErrorType.unauthorized, message: message);
  }

  factory AppError.notFound(String message) {
    return AppError(type: ErrorType.notFound, message: message);
  }

  factory AppError.apiResponse(String code, String message) {
    return AppError(type: ErrorType.apiResponse, message: message, code: code);
  }

  factory AppError.noInternet() {
    return AppError(
      type: ErrorType.noInternet,
      message:
          'No internet connection. Please check your network and try again.',
    );
  }

  factory AppError.unknown(String message, {dynamic originalError}) {
    return AppError(
      type: ErrorType.unknown,
      message: message,
      originalError: originalError,
    );
  }

  bool get isNetworkError =>
      type == ErrorType.network || type == ErrorType.noInternet;
  bool get isServerError => type == ErrorType.server;
  bool get isApiResponseError => type == ErrorType.apiResponse;
  bool get canRetry =>
      type != ErrorType.validation && type != ErrorType.unauthorized;

  String get userFriendlyMessage {
    switch (type) {
      case ErrorType.network:
      case ErrorType.noInternet:
        return 'Connection problem. Please check your internet and try again.';
      case ErrorType.server:
        return 'Server is having issues. Please try again later.';
      case ErrorType.timeout:
        return 'Request timed out. Please try again.';
      case ErrorType.unauthorized:
        return 'Session expired. Please login again.';
      case ErrorType.notFound:
        return 'Requested data not found.';
      case ErrorType.apiResponse:
        return message; // Use the API's message directly
      case ErrorType.validation:
        return message;
      case ErrorType.unknown:
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  @override
  String toString() {
    return 'AppError(type: $type, message: $message, code: $code, statusCode: $statusCode)';
  }
}
