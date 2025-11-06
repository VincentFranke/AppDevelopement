import 'package:flutter/material.dart';
import 'package:weather_app/ui/home_page.dart';
import 'package:weather_app/ui/themes/dark_theme.dart';
import 'package:weather_app/ui/themes/light_theme.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = 'Weather App';
    return MaterialApp(
      title: title,
      theme: LightTheme.getTheme(),
      darkTheme: DarkTheme.getTheme(),
      home: HomePage(title: title),
    );
  }
}
