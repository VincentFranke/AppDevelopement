import 'package:weather_app/logic/day_label.dart';

class DayForecastEntity {
  final DayLabel dayLabel;
  final double temperature;
  final int weatherCode;
  DayForecastEntity({
    required this.dayLabel,
    required this.temperature,
    required this.weatherCode,
  });
  DayForecastEntity.fromJson({
    required Map<String, dynamic> jsonData,
    required int index,
  }) : dayLabel =
           DayLabel.values[DateTime.parse(
                 jsonData['daily']['time'][index],
               ).weekday -
               1],
       temperature = jsonData['daily']['temperature_2m_max'][index],
       weatherCode = jsonData['daily']['weather_code'][index];
}
