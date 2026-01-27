import 'package:weather_app/features/day_forecast/domain/entities/day_forecast.dart';

abstract class DayForecastState {}

class DayForecastSuccess extends DayForecastState {
  final List<DayForecast> dayForecastEntityList;

  DayForecastSuccess({required this.dayForecastEntityList});
}

class DayForecastLoading extends DayForecastState {
  final int citiesForDayViewLength;

  DayForecastLoading({required this.citiesForDayViewLength});
}

class DayForecastPreLoading extends DayForecastState {}
