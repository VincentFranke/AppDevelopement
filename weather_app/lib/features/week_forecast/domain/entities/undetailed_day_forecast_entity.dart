import 'package:weather_app/core/enums/day_label_enum.dart';

class UndetailedDayForecast {
  final DayLabelEnum dayLabel;
  final double temperature;
  final int weatherCode;
  UndetailedDayForecast({
    required this.dayLabel,
    required this.temperature,
    required this.weatherCode,
  });
}
