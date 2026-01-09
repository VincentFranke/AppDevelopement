import 'package:weather_app/logic/entities/day_forecast_entity.dart';
import 'package:weather_app/logic/entities/week_forecast_entity.dart';

abstract class ForecastStates {}

class DisplayForecastDataState extends ForecastStates {
  final List<WeekForecastEntity> weekForecastEntityList;
  final List<DayForecastEntity> dayForecastEntityList;
  DisplayForecastDataState({
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
