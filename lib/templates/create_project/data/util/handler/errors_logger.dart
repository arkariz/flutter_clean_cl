class ErrorsLogger {
  static void Function(
    String message, 
    Object exception, 
    StackTrace? stackTrace
  ) logError = (message, exception, stackTrace) {};

  static void setLogger(void Function(String, Object, StackTrace?) errorLogger) {
    logError = errorLogger;
  }
}