part of 'add_city_bloc.dart';

sealed class AddCityEvent {}

final class AddCityAddCity extends AddCityEvent {
  City city;

  AddCityAddCity({required this.city});
}

class AddCityAddCities extends AddCityEvent {
  final List<City> cities;

  AddCityAddCities({required this.cities});
}
