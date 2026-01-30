import 'package:weather_app/features/day_forecast/domain/entities/day_forecast.dart';
import 'package:weather_app/features/week_forecast/domain/entities/week_forecast.dart';

abstract class WeekForecastStates {}

class WeekForecastSuccess extends WeekForecastStates {
  final bool bothViewsAlreadyExist;
  final List<WeekForecast> weekForecastEntityList;
  final List<DayForecast> dayForecastEntityList;
  WeekForecastSuccess({
    required this.bothViewsAlreadyExist,
    required this.weekForecastEntityList,
    required this.dayForecastEntityList,
  });
}

class WeekForecastLoading extends WeekForecastStates {
  final int numberOfCitiesDesignatedForDayView;
  final int numberOfCitiesDesignatedForWeekView;
  WeekForecastLoading({
    required this.numberOfCitiesDesignatedForDayView,
    required this.numberOfCitiesDesignatedForWeekView,
  });
}

class WeekForecastPreLoading extends WeekForecastStates {}

class WeekForecastError extends WeekForecastStates {}
