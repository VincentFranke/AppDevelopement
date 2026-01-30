import 'package:weather_app/core/enums/day_label_enum.dart';
import 'package:weather_app/features/week_forecast/domain/entities/undetailed_day_forecast_entity.dart';

class UndetailedDayForecastModel extends UndetailedDayForecast {
  UndetailedDayForecastModel({
    required super.dayLabel,
    required super.temperature,
    required super.weatherCode,
  });
  factory UndetailedDayForecastModel.fromJson({
    required Map<String, dynamic> jsonData,
    required int index,
  }) {
    return UndetailedDayForecastModel(
      dayLabel: DayLabelEnum
          .values[DateTime.parse(jsonData['daily']['time'][index]).weekday - 1],
      temperature: jsonData['daily']['temperature_2m_max'][index],
      weatherCode: jsonData['daily']['weather_code'][index],
    );
  }
}
