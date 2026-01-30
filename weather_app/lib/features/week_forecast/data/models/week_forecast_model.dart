import 'package:weather_app/features/week_forecast/domain/entities/week_forecast.dart';

class WeekForecastModel extends WeekForecast {
  WeekForecastModel({
    required super.id,
    required super.name,
    required super.undetailedDayForecastEntityList,
  });
}
