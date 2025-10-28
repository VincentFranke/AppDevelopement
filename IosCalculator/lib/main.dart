import 'package:flutter/material.dart';
import 'package:IosCalculator/Data.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff22272a),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsetsGeometry.zero,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            iconSize: 50,
            textStyle: TextStyle(fontSize: 40),
          ),
        ),
        textTheme: TextTheme(
          bodySmall: TextStyle(
            fontSize: 50,
            color: Color(0xff9b9fa1),
          ),
          bodyMedium: TextStyle(
            fontSize: 50,
            color: Color(0xffdededf),
          )
        )
      ),
      home: const Data(),
    );
  }
}
