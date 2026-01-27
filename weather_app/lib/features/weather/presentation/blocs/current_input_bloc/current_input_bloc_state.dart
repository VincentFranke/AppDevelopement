import 'package:weather_app/features/weather/domain/entities/city.dart';

class CurrentInputBlocState {
  final String currentInput;
  final List<City> citySuggestions;
  const CurrentInputBlocState({
    required this.currentInput,
    required this.citySuggestions,
  });
}
