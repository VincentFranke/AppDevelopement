import 'package:weather_app/logic/entities/city_entity.dart';
import 'package:weather_app/logic/view_type.dart';

abstract class ForecastBlocEvent {}

class HomePageRefreshEvent extends ForecastBlocEvent {}

class AddCityEvent extends ForecastBlocEvent {
  CityEntity cityEntity;
  final ViewType viewType;
  AddCityEvent({required this.cityEntity, required this.viewType});
}
