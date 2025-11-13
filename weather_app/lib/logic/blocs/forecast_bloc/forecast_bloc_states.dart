import 'package:weather_app/logic/entities/seven_day_forecast_entity.dart';

abstract class ForecastStates {}

class DisplayForecastDataState extends ForecastStates {
  final List<SevenDayForecastEntity> sevenDayForecastEntityList;
  DisplayForecastDataState({required this.sevenDayForecastEntityList});
}

class DisplayForecastLoadingScreenState extends ForecastStates {
  final int citysToDisplayCount;
  DisplayForecastLoadingScreenState({required this.citysToDisplayCount});
}

class DisplayForecastLoadingErrorState extends ForecastStates {}
