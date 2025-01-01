import 'package:flutter_clean_cli/commands/command_enum.dart';
import 'package:flutter_clean_cli/commands/impl/create.dart';
import 'package:flutter_clean_cli/commands/interface/commands.dart';

class CommandFinder {
  static Commands? find(String? command) {
    CommandEnum commandEnum = CommandEnum.fromString(command);
    
    switch (commandEnum) {
      case CommandEnum.create:
        return CreateCommand();
      default:
        return null;
    }
  }
}