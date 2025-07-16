// Base exception class
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

// Network related exceptions
class NoInternetException extends AppException {
  const NoInternetException(String message) : super(message);
}

class TimeoutException extends AppException {
  const TimeoutException(String message) : super(message);
}

class RequestCancelledException extends AppException {
  const RequestCancelledException(String message) : super(message);
}

// HTTP related exceptions
class BadRequestException extends AppException {
  const BadRequestException(String message) : super(message, 400);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException(String message) : super(message, 401);
}

class ForbiddenException extends AppException {
  const ForbiddenException(String message) : super(message, 403);
}

class NotFoundException extends AppException {
  const NotFoundException(String message) : super(message, 404);
}

class ValidationException extends AppException {
  const ValidationException(String message) : super(message, 422);
}

class ServerException extends AppException {
  const ServerException(String message) : super(message, 500);
}

class UnknownException extends AppException {
  const UnknownException(String message) : super(message);
}

// Data parsing exceptions
class DataParsingException extends AppException {
  const DataParsingException(String message) : super(message);
}

// Cache related exceptions
class CacheException extends AppException {
  const CacheException(String message) : super(message);
}
