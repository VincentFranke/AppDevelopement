import 'package:weather_app/features/day_forecast/domain/entities/day_forecast.dart';
import 'package:weather_app/features/week_forecast/domain/entities/week_forecast.dart';

abstract class ForecastStates {}

class DisplayForecastDataState extends ForecastStates {
  final bool bothViewsAlreadyExist;
  final List<WeekForecast> weekForecastEntityList;
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
