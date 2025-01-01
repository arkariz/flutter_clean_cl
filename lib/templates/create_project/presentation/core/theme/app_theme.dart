import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    )
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo, brightness: Brightness.dark),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    )
  );
}