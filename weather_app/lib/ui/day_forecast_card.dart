import 'package:flutter/material.dart';
import 'package:weather_app/logic/entities/day_forecast_entity.dart';
import 'package:weather_icons/weather_icons.dart';

class DayForecastCard extends StatelessWidget {
  final DayForecastEntity dayForecastEntity;
  const DayForecastCard({super.key, required this.dayForecastEntity});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(dayForecastEntity.dayLabel.label),
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(
              _getIcon(weatherCode: dayForecastEntity.weatherCode),
              size: 50,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text('${dayForecastEntity.temperature} °C'),
          ),
        ],
      ),
    );
  }

  IconData _getIcon({required int weatherCode}) {
    switch (weatherCode) {
      case 0:
        return WeatherIcons.day_sunny;
      case 1:
        return WeatherIcons.day_sunny_overcast;
      case 2:
        return WeatherIcons.day_cloudy;
      case 3:
        return WeatherIcons.cloudy;
      case 45:
      case 48:
        return WeatherIcons.fog;
      case 51:
      case 53:
        return WeatherIcons.sprinkle;
      case 55:
        return WeatherIcons.rain_mix;
      case 56:
      case 57:
        return WeatherIcons.sleet;
      case 61:
      case 63:
        return WeatherIcons.rain;
      case 65:
        return WeatherIcons.rain_wind;
      case 66:
      case 67:
        return WeatherIcons.sleet;
      case 71:
      case 73:
        return WeatherIcons.snow;
      case 75:
        return WeatherIcons.snow_wind;
      case 77:
        return WeatherIcons.snow;
      case 80:
      case 81:
        return WeatherIcons.showers;
      case 82:
        return WeatherIcons.rain_wind;
      case 85:
        return WeatherIcons.snow;
      case 86:
        return WeatherIcons.snow_wind;
      case 95:
      case 96:
      case 99:
        return WeatherIcons.thunderstorm;
      case _:
        return Icons.question_mark;
    }
  }
}
