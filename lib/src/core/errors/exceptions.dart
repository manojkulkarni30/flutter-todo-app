class AppException implements Exception {
  AppException({required this.message});

  final String message;

  @override
  String toString() => message;
}

class ServerException extends AppException {
  ServerException({
    super.message = 'Something went wrong. Please try again',
  });
}

class BadRequestException extends AppException {
  BadRequestException({super.message = 'Invalid request'});
}

class ResourceNotFoundException extends AppException {
  ResourceNotFoundException({super.message = 'Resource not found'});
}

class NetworkException extends AppException {
  NetworkException({
    super.message =
        'Unable to connect. Please check your internet connection and try again',
  });
}

class UnknownException extends AppException {
  UnknownException({
    super.message = 'An unexpected error occurred. Please try again',
  });
}
