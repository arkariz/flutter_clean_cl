import 'package:flutte_clean_cli/commands/command_enum.dart';

abstract class Commands {
  CommandEnum name = CommandEnum.unknown; 
  void execute();
}