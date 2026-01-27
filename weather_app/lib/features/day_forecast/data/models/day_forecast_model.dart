import 'package:weather_app/features/day_forecast/domain/entities/hourly_forecast.dart';

class DayForecastModel {
  final String id;
  final String name;
  final DateTime sunrise;
  final DateTime sunset;
  final String timeZone;
  final List<HourlyForecast> hourlyForecastList;
  const DayForecastModel({
    required this.id,
    required this.name,
    required this.sunrise,
    required this.sunset,
    required this.timeZone,
    required this.hourlyForecastList,
  });
  DayForecastModel.fromJson({
    required this.id,
    required this.name,
    required this.hourlyForecastList,
    required Map<String, dynamic> jsonData,
  }) : sunrise = DateTime.parse(jsonData['daily']['sunrise'].first),
       sunset = DateTime.parse(jsonData['daily']['sunset'].first),
       timeZone = jsonData['timezone'];
}
