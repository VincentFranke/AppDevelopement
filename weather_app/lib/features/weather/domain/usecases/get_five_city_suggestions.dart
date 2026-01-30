import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/enums/view_type.dart';
import 'package:weather_app/core/common/entities/city.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';

class GetFiveCitySuggestions {
  final WeatherRepository weatherRepository;

  GetFiveCitySuggestions({required this.weatherRepository});

  Future<Either<Failure, List<City>>> call({
    required String currentInput,
    required ViewType viewType,
  }) async {
    return await weatherRepository.getFiveCitySuggestions(
      currentInput: currentInput,
      viewType: viewType,
    );
  }
}
