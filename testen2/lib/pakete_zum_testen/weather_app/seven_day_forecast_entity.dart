import 'package:testen2/pakete_zum_testen/weather_app/day_forecast_entity.dart';

class SevenDayForecastEntity {
  final String header;
  final List<DayForecastEntity> dayForecastEntityList;
  const SevenDayForecastEntity({
    required this.header,
    required this.dayForecastEntityList,
  });
}
