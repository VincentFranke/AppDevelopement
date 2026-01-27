import 'package:flutter/material.dart';

class DarkTheme {
  static ThemeData getTheme() {
    return ThemeData.dark().copyWith(
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.blueGrey,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
