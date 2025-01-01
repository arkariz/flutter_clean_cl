import 'package:logger/logger.dart';
import '../../../data/util/handler/errors_logger.dart';

class LoggerUtil {
  static void setErrorsLog() {
    var logger = Logger(
      printer: PrettyPrinter(
        methodCount: 10,
        errorMethodCount: 50,
        lineLength: 150,
      ),
    );
    ErrorsLogger.setLogger(
      (message, exception, stackTrace) {
        logger.f(message, error: exception, stackTrace: stackTrace);
      },
    );
  }
}