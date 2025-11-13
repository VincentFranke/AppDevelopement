import 'package:weather_app/logic/entities/city_entity.dart';

abstract class ForecastBlocEvent {}

class HomePageRefreshEvent extends ForecastBlocEvent {}

class AddCityEvent extends ForecastBlocEvent {
  final CityEntity cityEntity;
  AddCityEvent({required this.cityEntity});
}
