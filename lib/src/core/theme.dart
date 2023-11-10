import 'package:flutter/material.dart';

class AppTheme {
  var currentTheme;

  AppTheme() {
    lightTheme();
  }

  void lightTheme() {
    currentTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      dividerColor: Colors.black12,
      primaryColorLight: const Color(0xff0079FF),
      textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 60, color: Color(0xff0079FF)),
          titleMedium: TextStyle(fontSize: 20, color: Color(0xff0079FF)),
          labelLarge: TextStyle(fontSize: 20, color: Colors.white)),
    );
  }

  void darkTheme() {
    currentTheme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black12),
        useMaterial3: true,
        dividerColor: Colors.orange,
        textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            labelSmall: TextStyle(fontWeight: FontWeight.w500)));
  }
}
