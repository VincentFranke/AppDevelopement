import 'package:flutter/material.dart';

class LightTheme {
  static ThemeData getTheme() {
    return ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(backgroundColor: Colors.yellow),
      cardTheme: CardThemeData(color: Colors.grey),
      textTheme: TextTheme(titleMedium: TextStyle(color: Colors.black)),
    );
  }
}
