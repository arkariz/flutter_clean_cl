import 'dart:io';

import 'package:flutter_clean_cli/utils/console_output.dart';
import 'package:flutter_clean_cli/utils/string_extention.dart';
import 'package:flutter_clean_cli/version.dart';

class CreateDataModule {
  Future<void> execute() async {
    final fileName = ConsoleOutput.inputPrompt('Enter your module name (example: user_profile): ');
    await _generateTemplate(fileName);
    await _addDatasource(fileName);
    await _addRepository(fileName);
  }


  /// Generates template files from the predefined template directory.
  Future<void> _generateTemplate(String fileName) async {
    final templateDir = _getTemplateDirectory();
    for (final file in templateDir.listSync(recursive: true)) {
      if (file is File) {
        String relativePath = file.path.replaceFirst(templateDir.path, '');
        relativePath = relativePath.replaceAll('example', fileName);
        final outputPath = 'lib/$relativePath';
        final outputFile = File(outputPath);

        outputFile.createSync(recursive: true);
        String updatedContent = await file.readAsString();
        updatedContent = updatedContent.replaceAll('{{name}}', fileName.toCamelCase());
        updatedContent = updatedContent.replaceAll('{{fileName}}', fileName);
        updatedContent = updatedContent.replaceFirst('/*', '').replaceFirst('*/', '');
        await outputFile.writeAsString(updatedContent);
      }
    }

    ConsoleOutput.log(successOutput: 'Template generated successfully');
  }

  Future<void> _addDatasource(String fileName) async {
    final diFile = _getDiFile();
    String content = await diFile.readAsString();
    String updatedContent = content.replaceFirst(
      RegExp(r'    // Datasource'),
      '''
    // Datasource
    getIt.registerFactory<${fileName.toCamelCase()}Datasource>(() => Remote${fileName.toCamelCase()}Datasource(
      exampleManager: GetIt.I(),
      exampleServiceConfig: GetIt.I(),
    ));
      ''',
    );
    updatedContent = updatedContent.replaceFirst(
      RegExp(r';'),
      ";\nimport '../../module/$fileName/datasource/${fileName}_datasource.dart';\nimport '../../module/$fileName/datasource/remote_${fileName}_datasource.dart';",
    );
    await diFile.writeAsString(updatedContent);
    ConsoleOutput.log(successOutput: '${fileName}Datasource added to dependency injection');
  }

  Future<void> _addRepository(String fileName) async {
    final diFile = _getDiFile();
    String content = await diFile.readAsString();
    String updatedContent = content.replaceFirst(
      RegExp(r'// Repository'),
      '// Repository\n    getIt.registerFactory<${fileName.toCamelCase()}Repository>(() => Impl${fileName.toCamelCase()}Repository(remoteDatasource: GetIt.I()));',
    );
    updatedContent = updatedContent.replaceFirst(
      RegExp(r';'),
      ";\nimport '../../../domain/module/$fileName/repository/${fileName}_repository.dart';\nimport '../../module/$fileName/repository/impl_${fileName}_repository.dart';",
    );
    await diFile.writeAsString(updatedContent);
    ConsoleOutput.log(successOutput: '${fileName}Repository added to dependency injection');
  }

  /// Returns the template directory for generating files.
  Directory _getTemplateDirectory() {
    final currentUri = Platform.script;
    final absolutePath = Directory(currentUri.toFilePath()).parent.parent.parent.parent.path;
    final dir = Directory("$absolutePath/hosted/pub.dev/flutter_clean_cli-$version/lib/templates/create_data_module");
    if (!dir.existsSync()) {
      ConsoleOutput.log(errorOutput: 'Error: Template does not exist in ${dir.path}');
      exit(1);
    } else {
      return dir;
    }
  }

  File _getDiFile() {
    final currentDir = Directory.current.path;
    final diFile = File('$currentDir/lib/data/util/di/data_dependecies_injection.dart');
    if (!diFile.existsSync()) {
      ConsoleOutput.log(errorOutput: 'Error: $diFile does not exist');
      exit(1);
    } else {
      return diFile;
    }
  }
}