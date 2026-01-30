import 'package:weather_app/features/day_forecast/domain/entities/hourly_forecast.dart';

class HourlyForecastModel extends HourlyForecast {
  HourlyForecastModel({
    required super.time,
    required super.temperature,
    required super.weatherCode,
  });

  factory HourlyForecastModel.fromJson({
    required Map<String, dynamic> jsonData,
    required int index,
  }) {
    return HourlyForecastModel(
      temperature: jsonData['hourly']['temperature_2m'][index],
      weatherCode: jsonData['hourly']['weather_code'][index],
      time: DateTime.parse(jsonData['hourly']['time'][index]),
    );
  }
}
