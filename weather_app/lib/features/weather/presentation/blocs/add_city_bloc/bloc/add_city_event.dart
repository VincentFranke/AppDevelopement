part of 'add_city_bloc.dart';

sealed class AddCityEvent {}

final class AddCityAddCity extends AddCityEvent {
  City cityEntity;
  final ViewType viewType;

  AddCityAddCity({required this.cityEntity, required this.viewType});
}

class AddCityAddMultipleCitys extends AddCityEvent {
  final List<AddCityAddCity> citiesAndViewTypes;

  AddCityAddMultipleCitys({required this.citiesAndViewTypes});
}
