import 'package:weather_app/logic/entities/day_forecast_entity.dart';

class SevenDayForecastEntity {
  final String header;
  final List<DayForecastEntity> dayForecastEntityList;
  const SevenDayForecastEntity({
    required this.header,
    required this.dayForecastEntityList,
  });
}
