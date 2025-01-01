import '../../../app/exception/custome_exception.dart';
import 'errors_logger.dart';

class DatasourceHandler {
  // Handle http request
  Future<T> handleRequest<T>(
    Future<T> Function() operation,
  ) async {
    try {
      return await operation();
    } on NoInternetException catch (error) {
      ErrorsLogger.logError(error.message, error, error.stackTrace);
      rethrow;
    } on RequestTimeoutException catch (error) {
      ErrorsLogger.logError(error.message, error, error.stackTrace);
      rethrow;
    } on BadResponseException catch (error) {
      ErrorsLogger.logError(error.message, error, error.stackTrace);
      rethrow;
    } catch (error, stackTrace) {
      ErrorsLogger.logError(error.toString(), error, stackTrace);
      rethrow;
    }
  }

  // Handle local database connection
  Future<T> handleConnection<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } catch (error, stackTrace) {
      LocalStorageException exception = LocalStorageException(message: error.toString(), exception: error, stackTrace: stackTrace);
      ErrorsLogger.logError(error.toString(), exception, stackTrace);
      throw exception;
    }
  }


  // Handle decode process
  T handleDecode<T>(T Function() operation) {
    try {
      return operation();
    } on NoSuchMethodError catch (error, stackTrace) {
      DataNotfoundException exception = DataNotfoundException(message: error.toString(), exception: error, stackTrace: stackTrace);
      ErrorsLogger.logError(error.toString(), exception, stackTrace);
      throw exception;
    } catch (error, stackTrace) {
      DecodeFailedException exception = DecodeFailedException(message: error.toString(), exception: error, stackTrace: stackTrace);
      ErrorsLogger.logError(error.toString(), exception, stackTrace);
      throw exception;
    }
  }
}