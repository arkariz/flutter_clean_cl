import 'dart:ui';

extension ColorExtention on Color {
  String get hexString {
    return '#${value.toRadixString(16).substring(2)}';
  }
}