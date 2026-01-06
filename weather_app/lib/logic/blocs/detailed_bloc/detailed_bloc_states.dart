import 'package:weather_app/logic/entities/detailed_day_forecast_entity.dart';

abstract class DetailedBlocStates {}

class ShowDataDetailedBlocState extends DetailedBlocStates {
  final DetailedDayForecastEntity detailedDayForecastEntity;
  ShowDataDetailedBlocState({required this.detailedDayForecastEntity});
}

class LoadingDetailedBlocState extends DetailedBlocStates {}
