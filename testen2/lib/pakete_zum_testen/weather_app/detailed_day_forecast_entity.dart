import 'package:testen2/pakete_zum_testen/weather_app/hourly_forecast_entity.dart';

class DetailedDayForecastEntity {
  final String header;
  final List<HourlyForecastEntity> hourlyForecastEntityList;
  const DetailedDayForecastEntity({
    required this.header,
    required this.hourlyForecastEntityList,
  });
}
