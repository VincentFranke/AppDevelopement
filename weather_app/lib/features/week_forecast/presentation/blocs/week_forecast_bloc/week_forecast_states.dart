import 'package:weather_app/features/week_forecast/domain/entities/week_forecast.dart';

abstract class WeekForecastStates {}

class WeekForecastSuccess extends WeekForecastStates {
  final WeekForecast weekForecast;
  WeekForecastSuccess({required this.weekForecast});
}

class WeekForecastLoading extends WeekForecastStates {}

class WeekForecastError extends WeekForecastStates {
  final String message;

  WeekForecastError({required this.message});
}
