import 'package:flutter/material.dart';

enum AppTheme {
  darkMode("Dark Mode", Icons.dark_mode),
  defaultMode("Default Mode", Icons.light_mode);

  final String name;
  final IconData icon;
  const AppTheme(this.name, this.icon);
}

final appThemeData = {
  AppTheme.darkMode: ThemeData(
      secondaryHeaderColor: Colors.black,
      dialogBackgroundColor: Colors.black54,
      dividerColor: Colors.black,
      cardColor: Colors.black26,
      highlightColor: Colors.black26,
      shadowColor: Colors.grey.shade900,
      scaffoldBackgroundColor: Color(0xFF333333),
      canvasColor: Color(0xFF000000),
      iconTheme: IconThemeData(color: Colors.black),
      textTheme: TextTheme(
          titleLarge:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      appBarTheme: AppBarTheme(backgroundColor: Color(0xFF333333)),
      brightness: Brightness.dark,
      primaryColor: Color(0xFF000000),
      bottomAppBarTheme: BottomAppBarTheme(color: Color(0xFF333333))),
  // DEFAULT
  AppTheme.defaultMode: ThemeData(
    highlightColor: Colors.white,
    secondaryHeaderColor: Color(0xFF667085),
    dialogBackgroundColor: Color(0xFFF9FAF5),
    dividerColor: Color(0xFF182230),
    cardColor: Color(0xFFF9FAFB),
    shadowColor: Colors.black12,
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    canvasColor: Color(0xFFEAECF0),
    iconTheme: IconThemeData(color: Color(0xFF344054)),
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFFFFFFFF)),
    brightness: Brightness.light,
    primaryColor: Color(0xFFFFFFFF),
    bottomAppBarTheme: BottomAppBarTheme(color: Color(0xFFFFFFFF)),
    // TEXT THEME LARGE
    textTheme: TextTheme(
        // medium

        titleLarge:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
  )
};
