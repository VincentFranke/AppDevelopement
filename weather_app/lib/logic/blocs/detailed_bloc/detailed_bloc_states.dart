import 'package:weather_app/logic/entities/hourly_forecast_entity.dart';

abstract class DetailedBlocStates {}

class ShowDataDetailedBlocState extends DetailedBlocStates {
  final List<HourlyForecastEntity> hourlyForecastEntityList;
  ShowDataDetailedBlocState({required this.hourlyForecastEntityList});
}

class LoadingDetailedBlocState extends DetailedBlocStates {}
