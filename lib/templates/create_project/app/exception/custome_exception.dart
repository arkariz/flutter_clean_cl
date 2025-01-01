class NoInternetException implements Exception {
  final String message;
  final Object? exception;
  final StackTrace? stackTrace;

  NoInternetException({this.message = "No internet connection", this.exception, this.stackTrace});
}

class DecodeFailedException implements Exception {
  final String message;
  final Object? exception;
  final StackTrace? stackTrace;

  DecodeFailedException({required this.message, this.exception, this.stackTrace});
}

class RequestTimeoutException implements Exception {
  final String message;
  final Object? exception;
  final StackTrace? stackTrace;

  RequestTimeoutException({required this.message, this.exception, this.stackTrace});
}

class BadResponseException implements Exception {
  final String message;
  final Object? exception;
  final StackTrace? stackTrace;

  BadResponseException({required this.message, this.exception, this.stackTrace});
}

class DataNotfoundException implements Exception {
  final String message;
  final Object? exception;
  final StackTrace? stackTrace;

  DataNotfoundException({required this.message, this.exception, this.stackTrace});
}

class LocalStorageException implements Exception {
  final String message;
  final Object? exception;
  final StackTrace? stackTrace;

  LocalStorageException({required this.message, this.exception, this.stackTrace});
}