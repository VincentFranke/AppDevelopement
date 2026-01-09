import 'package:weather_app/logic/entities/city_entity.dart';

class CurrentInputBlocState {
  final String currentInput;
  final List<CityEntity> citySuggestions;
  const CurrentInputBlocState({
    required this.currentInput,
    required this.citySuggestions,
  });
}
