import 'package:flutter_clean_cli/options/create/create_enum.dart';
import 'package:flutter_clean_cli/options/create/project/create_project.dart';
import 'package:flutter_clean_cli/options/interface/options.dart';
import '../../utils/console_output.dart';

class CreateOptions extends Options {
  @override
  List<Create> get options => [Create.project, Create.module];

  @override
  void onSelectedOptions(Enum option) async {
    switch (option) {
      case Create.project:
        CreateProject().execute();
        break;
      default:
        ConsoleOutput.log(errorOutput: "Invalid option selected");
    }
  }

  
}