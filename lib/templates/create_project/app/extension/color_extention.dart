// ignore_for_file: deprecated_member_use

import 'dart:ui';

extension ColorExtention on Color {
  String get hexString {
    return '#${value..toRadixString(16).substring(2)}';
  }
}