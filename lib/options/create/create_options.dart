import 'dart:io';
import 'package:flutter_clean_cli/options/create/create_enum.dart';
import 'package:flutter_clean_cli/options/interface/options.dart';

import '../../utils/console_output.dart';
import '../../version.dart';

class CreateOptions extends Options {
  @override
  List<Create> get options => [Create.project, Create.module];

  @override
  void onSelectedOptions(Enum option) async {
    switch (option) {
      case Create.project:
        await _runFlutterCreate();
        _addDependencies();
        await _addEnvAsset();
        _generateTemplate();
        _addLaunchJson();
        await _addLocalizations();
        break;
      default:
        ConsoleOutput.log(errorOutput: "Invalid option selected");
    }
  }

  /// Runs the `flutter create .` command in the current directory.
  Future<void> _runFlutterCreate() async {
    final org = ConsoleOutput.inputPrompt('Enter your org: ');
    ConsoleOutput.log(infoOutput: 'Running "flutter create ." in the current directory...');

    final process = await Process.start(
      'flutter',
      [
        'create', '.',
        '--template', 'app',
        '--platforms', 'android,ios',
        if (org.isNotEmpty) '--org', org
      ],
    );

    ConsoleOutput.processOutput(process);

    final exitCode = await process.exitCode;
    if (exitCode == 0) {
      ConsoleOutput.log(successOutput: 'Flutter project created successfully!');
    } else {
      ConsoleOutput.log(errorOutput: 'Failed to create Flutter project. Exit code: $exitCode');
    }
  }

  /// Edits the pubspec.yaml file to include necessary dependencies.
  void _addDependencies() {
    final dependencies = [
      "connectivity_plus",
      "dartz",
      "equatable",
      "get_it",
      "lints",
      "shared_preferences",
      "dio",
      "dio_request_inspector",
      "flutter_dotenv",
      "logger",
      "slang",
      "slang_flutter",
      "toastification",
    ];

    final pubspecFile = _getPubspecFile();

    var content = pubspecFile.readAsStringSync();
    for (var dependency in dependencies) {
      if (!content.contains(dependency)) {
        content = content.replaceFirst(
          RegExp(r'dependencies:'),
          'dependencies:\n  $dependency: any',
        );
      }
    }

    pubspecFile.writeAsStringSync(content);
    ConsoleOutput.log(successOutput: 'pubspec.yaml updated successfully');
  }

  Future<void> _addEnvAsset() async {
    final pubspecFile = _getPubspecFile();
    final content = await pubspecFile.readAsString();
    final updatedContent = content.replaceFirst(
      RegExp(r'  # assets:'),
      '  assets:\n    - lib/presentation/flavor/env/',
    );
    await pubspecFile.writeAsString(updatedContent);
    ConsoleOutput.log(successOutput: 'env asset added to pubspec.yaml');
  }

  /// Generates template files from the predefined template directory.
  void _generateTemplate() {
    final templateDir = _getTemplateDirectory();

    for (final file in templateDir.listSync(recursive: true)) {
      if (file is File) {
        final relativePath = file.path.replaceFirst(templateDir.path, '');
        final outputPath = 'lib/$relativePath';
        final outputFile = File(outputPath);

        outputFile.createSync(recursive: true);
        final updatedContent = file.readAsStringSync().replaceAll('{{name}}', 'GeneratedName');
        outputFile.writeAsStringSync(updatedContent);
      }
    }

    ConsoleOutput.log(successOutput: 'Template generated successfully');
  }

  void _addLaunchJson() {
    _createFile('launch.json', '.vscode/launch.json');
    ConsoleOutput.log(successOutput: 'launch.json generated successfully');
  }

  Future<void> _addLocalizations() async {
    ConsoleOutput.log(infoOutput: "Running 'dart run slang' in the current directory...");
    _createFile('i18n.json', 'lib', isRelative: true);
    _createFile('slang.yaml', "slang.yaml");
    final pubspecFile = _getPubspecFile();
    final content = await pubspecFile.readAsString();
    final updatedContent = content.replaceFirst(
      RegExp(r'  assets:'),
      '  assets:\n    - lib/resources/i18n/',
    );
    await pubspecFile.writeAsString(updatedContent);

    final process = await Process.start(
      'dart', ['run', 'slang'],
    );
    ConsoleOutput.processOutput(process);
    final exitCode = await process.exitCode;
    if (exitCode == 0) {
      ConsoleOutput.log(successOutput: 'Slang generated successfully');
    } else {
      ConsoleOutput.log(errorOutput: 'Failed to generate Slang. Exit code: $exitCode');
    }
  }

  /// Returns the template directory for generating files.
  Directory _getTemplateDirectory() {
    final currentUri = Platform.script;
    final absolutePath = Directory(currentUri.toFilePath()).parent.parent.parent.parent.path;
    final dir = Directory("$absolutePath/hosted/pub.dev/flutter_clean_cli-$version/lib/templates/create_project");
    if (!dir.existsSync()) {
      ConsoleOutput.log(errorOutput: 'Error: Template does not exist in ${dir.path}');
      exit(1);
    } else {
      return dir;
    }
  }
  
  File _getPubspecFile() {
    final pubspecFile = File('pubspec.yaml');
    if (!pubspecFile.existsSync()) {
      ConsoleOutput.log(errorOutput: 'Error: pubspec.yaml does not exist');
      exit(1);
    } else {
      return pubspecFile;
    }
  }

  void _createFile(String fileName, String output, {bool isRelative = false}) {
    final templateDir = _getTemplateDirectory();
    for (final file in templateDir.listSync(recursive: true)) {
      if (file is File && file.path.endsWith(fileName)) {
        final relativePath = file.path.replaceFirst(templateDir.path, '');
        final outputFile =  isRelative ? File('$output/$relativePath') : File(output);
        outputFile.createSync(recursive: true);
        final updatedContent = file.readAsStringSync();
        outputFile.writeAsStringSync(updatedContent);
      }
    }
  }
}