import 'package:weather_app/features/day_forecast/domain/entities/day_forecast.dart';
import 'package:weather_app/core/common/entities/week_forecast_entity.dart';

abstract class WeekForecastState {}

class WeekForecastSuccess extends WeekForecastState {
  final bool bothViewsAlreadyExist;
  final List<WeekForecastEntity> weekForecastEntityList;
  final List<DayForecast> dayForecastEntityList;
  WeekForecastSuccess({
    required this.bothViewsAlreadyExist,
    required this.weekForecastEntityList,
    required this.dayForecastEntityList,
  });
}

class WeekForecastLoading extends WeekForecastState {
  final int numberOfCitiesDesignatedForDayView;
  final int numberOfCitiesDesignatedForWeekView;
  WeekForecastLoading({
    required this.numberOfCitiesDesignatedForDayView,
    required this.numberOfCitiesDesignatedForWeekView,
  });
}

class WeekForecastPreLoading extends WeekForecastState {}

class WeekForecastError extends WeekForecastState {}
