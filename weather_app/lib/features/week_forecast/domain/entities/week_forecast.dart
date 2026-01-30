import 'package:weather_app/features/week_forecast/domain/entities/undetailed_day_forecast_entity.dart';

class WeekForecast {
  final String id;
  final String name;
  final List<UndetailedDayForecast> undetailedDayForecastEntityList;
  const WeekForecast({
    required this.id,
    required this.name,
    required this.undetailedDayForecastEntityList,
  });
}
