import 'package:flutte_clean_cli/commands/command_enum.dart';
import 'package:flutte_clean_cli/commands/interface/commands.dart';
import 'package:flutte_clean_cli/options/create/create_options.dart';

class CreateCommand implements Commands {
  @override
  CommandEnum name = CommandEnum.create;
  
  @override
  void execute() {
    CreateOptions().displayOptions();
  }
}