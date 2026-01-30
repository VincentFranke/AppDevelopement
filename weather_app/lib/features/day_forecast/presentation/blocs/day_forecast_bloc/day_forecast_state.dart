import 'package:weather_app/features/day_forecast/domain/entities/day_forecast.dart';

abstract class DayForecastState {}

class DayForecastLoading extends DayForecastState {}

class DayForecastSuccess extends DayForecastState {
  final DayForecast dayForecast;

  DayForecastSuccess({required this.dayForecast});
}

class DayForecastError extends DayForecastState {
  final String message;

  DayForecastError({required this.message});
}
