import 'package:weather_app/features/week_forecast/domain/entities/undetailed_day_forecast_entity.dart';

class WeekForecastEntity {
  final String id;
  final String name;
  final List<UndetailedDayForecastEntity> undetailedDayForecastEntityList;
  const WeekForecastEntity({
    required this.id,
    required this.name,
    required this.undetailedDayForecastEntityList,
  });
}
