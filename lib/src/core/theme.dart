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
          headlineMedium: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
          headlineLarge: TextStyle(
              fontFamily: 'Rubik',
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(
              fontFamily: 'Rubik',
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
            fontFamily: 'RubikMonoOne',
            fontSize: 50,
            color: Color(0xFF0079FF),
            fontWeight: FontWeight.w900,
            height: 1,
          ),
          displayLarge: TextStyle(
            fontFamily: 'Rubik',
            color: Colors.black,
            fontSize: 15,
          ),
          bodySmall: TextStyle(
              fontFamily: 'Rubik', fontSize: 15, color: Color(0xFF94C7FF)),
          headlineSmall: TextStyle(
              fontFamily: 'Rubik', fontSize: 17, color: Color(0xFF0079FF)),
          displaySmall: TextStyle(
              fontFamily: 'Rubik', fontSize: 12, color: Color(0xFF0079FF)),
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
