import 'package:weather_app/features/day_forecast/domain/entities/day_forecast.dart';
import 'package:weather_app/core/common/entities/week_forecast_entity.dart';

abstract class ForecastStates {}

class DisplayForecastDataState extends ForecastStates {
  final bool bothViewsAlreadyExist;
  final List<WeekForecastEntity> weekForecastEntityList;
  final List<DayForecast> dayForecastEntityList;
  DisplayForecastDataState({
    required this.bothViewsAlreadyExist,
    required this.weekForecastEntityList,
    required this.dayForecastEntityList,
  });
}

class DisplayForecastLoadingScreenState extends ForecastStates {
  final int numberOfCitiesDesignatedForDayView;
  final int numberOfCitiesDesignatedForWeekView;
  DisplayForecastLoadingScreenState({
    required this.numberOfCitiesDesignatedForDayView,
    required this.numberOfCitiesDesignatedForWeekView,
  });
}

class DisplayForecastPreLoadingScreenState extends ForecastStates {}

class DisplayForecastLoadingErrorState extends ForecastStates {}
