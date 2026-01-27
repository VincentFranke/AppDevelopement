import 'package:weather_app/features/day_forecast/domain/entities/hourly_forecast.dart';

class DayForecast {
  final String id;
  final String name;
  final DateTime sunrise;
  final DateTime sunset;
  final String timeZone;
  final List<HourlyForecast> hourlyForecastList;
  const DayForecast({
    required this.id,
    required this.name,
    required this.sunrise,
    required this.sunset,
    required this.timeZone,
    required this.hourlyForecastList,
  });
}
