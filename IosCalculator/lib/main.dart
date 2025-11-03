import 'package:IosCalculator/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Nur Hochformat zulassen
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Hochkant normal
    DeviceOrientation.portraitDown, // Hochkant upside down (optional)
  ]).then((_) {
    runApp(Calculator());
  });
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 36, 39, 39),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsetsGeometry.zero,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            iconSize: 50,
            textStyle: TextStyle(fontSize: 50),
          ),
        ),
        textTheme: TextTheme(
          bodySmall: TextStyle(fontSize: 45, color: Color(0xff9b9fa1)),
          bodyMedium: TextStyle(fontSize: 60, color: Color(0xffdededf)),
        ),
      ),
      home: const HomePage(),
    );
  }
}
