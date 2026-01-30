import 'package:weather_app/features/day_forecast/domain/entities/day_forecast.dart';
import 'package:weather_app/features/day_forecast/domain/entities/hourly_forecast.dart';

class DayForecastModel extends DayForecast {
  const DayForecastModel({
    required super.id,
    required super.name,
    required super.sunrise,
    required super.sunset,
    required super.timeZone,
    required super.hourlyForecastList,
  });
  factory DayForecastModel.fromJson({
    required String id,
    required String name,
    required List<HourlyForecast> hourlyForecastList,
    required Map<String, dynamic> jsonData,
  }) {
    return DayForecastModel(
      id: id,
      name: name,
      hourlyForecastList: hourlyForecastList,
      timeZone: jsonData['timezone'],
      sunrise: DateTime.parse(jsonData['daily']['sunrise'].first),
      sunset: DateTime.parse(jsonData['daily']['sunset'].first),
    );
  }
}
