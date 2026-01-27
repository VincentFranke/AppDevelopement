import 'package:weather_app/features/weather/domain/entities/city.dart';
import 'package:weather_app/core/enums/view_type.dart';

abstract class WeekForecastEvent {}

class WeekForecastRefresh extends WeekForecastEvent {}

class WeekForecastAddCity extends WeekForecastEvent {
  City cityEntity;
  final ViewType viewType;

  WeekForecastAddCity({required this.cityEntity, required this.viewType});
}

class WeekForecastAddMultipleCitys extends WeekForecastEvent {
  final Map<City, ViewType> citysAndViewTypes;

  WeekForecastAddMultipleCitys({required this.citysAndViewTypes});
}
