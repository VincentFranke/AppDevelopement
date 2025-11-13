import 'package:weather_app/logic/entities/city_entity.dart';

class CurrentInputBlocState {
  final List<CityEntity> citySuggestions;
  const CurrentInputBlocState({required this.citySuggestions});
}
