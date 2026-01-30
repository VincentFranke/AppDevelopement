import 'package:weather_app/features/weather/domain/entities/city.dart';

abstract class DayForecastEvent {}

class DayForecastRequestRefresh extends DayForecastEvent {
  final City city;

  DayForecastRequestRefresh({required this.city});
}
