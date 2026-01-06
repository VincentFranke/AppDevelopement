import 'package:weather_app/logic/entities/hourly_forecast_entity.dart';

class DetailedDayForecastEntity {
  final DateTime sunrise;
  final DateTime sunset;
  final List<HourlyForecastEntity> hourlyForecastEntityList;
  const DetailedDayForecastEntity({
    required this.sunrise,
    required this.sunset,
    required this.hourlyForecastEntityList,
  });
  DetailedDayForecastEntity.fromJson({
    required this.hourlyForecastEntityList,
    required Map<String, dynamic> jsonData,
  }) : sunrise = DateTime.parse(jsonData['daily']['sunrise'].first),
       sunset = DateTime.parse(jsonData['daily']['sunset'].first);
}
