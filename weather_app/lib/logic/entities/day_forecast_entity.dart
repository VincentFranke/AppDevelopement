import 'package:weather_app/logic/entities/hourly_forecast_entity.dart';

class DayForecastEntity {
  final String id;
  final String name;
  final DateTime sunrise;
  final DateTime sunset;
  final List<HourlyForecastEntity> hourlyForecastEntityList;
  const DayForecastEntity({
    required this.id,
    required this.name,
    required this.sunrise,
    required this.sunset,
    required this.hourlyForecastEntityList,
  });
  DayForecastEntity.fromJson({
    required this.id,
    required this.name,
    required this.hourlyForecastEntityList,
    required Map<String, dynamic> jsonData,
  }) : sunrise = DateTime.parse(jsonData['daily']['sunrise'].first),
       sunset = DateTime.parse(jsonData['daily']['sunset'].first);
}
