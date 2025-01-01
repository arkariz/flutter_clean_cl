#!/usr/bin/env dart

import 'package:args/args.dart';
import 'package:flutte_clean_cli/commands/command_finder.dart';

const String version = '0.0.1';

final createParser = ArgParser()
  ..addOption(
    'name',
    abbr: 'n',
    help: 'The name of the new project.',
    defaultsTo: 'my_flutter_app',
  );

ArgParser buildParser() {
  return ArgParser()
    ..addCommand('create', createParser)
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag(
      'version',
      negatable: false,
      help: 'Print the tool version.',
    );
}

void printUsage(ArgParser argParser) {
  print('Usage: dart flutte_clean_cli.dart <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);
    CommandFinder.find(results.command?.name)?.execute();
  } on FormatException catch (e) {
    print(e.message);
    print('');
    printUsage(argParser);
  }
}

