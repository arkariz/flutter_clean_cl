import 'dart:io';
import 'package:dart_console/dart_console.dart';
import 'package:flutter_clean_cli/options/create/create_enum.dart';

class Options {

  final console = Console();
  int selectedIndex = 0;
  
  List<Enum> options = [Create.project, Create.module];
  void onSelectedOptions(Enum option) {}

  // Fungsi untuk menampilkan opsi
  void setOptions() {
    console.writeLine('Use Arrow Keys to navigate and Enter to select:');
    for (var i = 0; i < options.length; i++) {
      if (i == selectedIndex) {
        console.setForegroundColor(ConsoleColor.brightBlue);
        console.writeLine('> ${options[i].name}'); // Opsi yang dipilih
        console.resetColorAttributes();
      } else {
        console.writeLine('  ${options[i].name}'); // Opsi lainnya
      }
    }
  }

  void displayOptions() {
    setOptions();
    while (true) {
      final key = console.readKey();
      if (key.controlChar == ControlCharacter.arrowUp) {
        console.clearScreen();
        if (selectedIndex > 0) {
          selectedIndex--;
          setOptions();
        }
      } else if (key.controlChar == ControlCharacter.arrowDown) {
        console.clearScreen();
        if (selectedIndex < options.length - 1) {
          selectedIndex++;
          setOptions();
        }
      } else if (key.controlChar == ControlCharacter.enter) {
        console.clearScreen();
        onSelectedOptions(options[selectedIndex]);
        break;
      } else if (key.controlChar == ControlCharacter.ctrlC) {
        console.clearScreen();
        console.writeLine('Exited.');
        exit(0);
      }
    }
  }
}
