import 'package:weather_app/features/weather/domain/entities/city.dart';

abstract class CurrentInputState {}

class RequestSuccessfull extends CurrentInputState {
  final String currentInput;
  final List<City> citySuggestions;

  RequestSuccessfull({
    required this.currentInput,
    required this.citySuggestions,
  });
}

class RequestFailed extends CurrentInputState {
  final String message;

  RequestFailed({required this.message});
}
