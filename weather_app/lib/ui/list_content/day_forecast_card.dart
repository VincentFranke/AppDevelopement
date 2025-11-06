import 'package:flutter/material.dart';

class DayForecastCard extends StatelessWidget {
  final String title;
  final int temperature;
  final IconData weatherIcon;
  const DayForecastCard({
    super.key,
    required this.title,
    required this.temperature,
    required this.weatherIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Align(alignment: Alignment.topCenter, child: Text(title)),
          Align(
            alignment: Alignment.center,
            child: Icon(weatherIcon, size: 50),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text('$temperature °C'),
          ),
        ],
      ),
    );
  }
}
