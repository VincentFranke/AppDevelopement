import 'package:weather_app/logic/day_label_enum.dart';

class UndetailedDayForecastEntity {
  final DayLabelEnum dayLabel;
  final double temperature;
  final int weatherCode;
  UndetailedDayForecastEntity({
    required this.dayLabel,
    required this.temperature,
    required this.weatherCode,
  });
  UndetailedDayForecastEntity.fromJson({
    required Map<String, dynamic> jsonData,
    required int index,
  }) : dayLabel =
           DayLabelEnum.values[DateTime.parse(
                 jsonData['daily']['time'][index],
               ).weekday -
               1],
       temperature = jsonData['daily']['temperature_2m_max'][index],
       weatherCode = jsonData['daily']['weather_code'][index];
}
