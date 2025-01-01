import 'dart:io';

class ConsoleOutput {
  static void log({String? successOutput, String? errorOutput, String? infoOutput, String? systemOutput}) {
    const String resetColor = '\x1B[0m';
    const String yellowColor = '\x1B[33m';
    const String greenColor = '\x1B[32m';
    const String redColor = '\x1B[31m';

    if (errorOutput != null) {
      stderr.write("$redColor❌ $errorOutput$resetColor");
      stdout.write("\n$redColor=====================================================================$resetColor\n\n");
    }
    if (successOutput != null) {
      stdout.write("$greenColor✅ $successOutput$resetColor");
      stdout.write("\n$greenColor=====================================================================$resetColor\n\n");
    }
    if (infoOutput != null) {
      stdout.write("$greenColor🛠️  $infoOutput$resetColor");
      stdout.write("\n$greenColor=====================================================================$resetColor\n\n");
    }
    if (systemOutput != null) {
      stdout.write("$yellowColor$systemOutput$resetColor");
    }
  }

  /// Prompts the user for input and returns their response.
  static String inputPrompt(String prompt) {
    stdout.write(prompt);
    return stdin.readLineSync() ?? '';
  }

  /// Handles process output and redirects it to stdout and stderr.
  static void processOutput(Process process) {
    process.stdout.transform(SystemEncoding().decoder).listen((data) {
      log(systemOutput: data);
    });

    process.stderr.transform(SystemEncoding().decoder).listen((data) {
      log(errorOutput: data);
    });
  }
}