import 'dart:ui';

extension StringExtension on String {
  bool isValidEmail() {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }

  bool isValidPhoneNumber() {
    return RegExp(r"^(^\+62\s?|^0)(\d{3,4}-?){2}\d{3,4}$").hasMatch(this);
  }

  bool isNoSpecialCharacter() {
    return RegExp(r"^[a-zA-Z0-9 ]+$").hasMatch(this);
  }

  Color toColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}