import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/common/entities/city.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';

class SaveCity {
  final WeatherRepository weatherRepository;

  SaveCity({required this.weatherRepository});

  Future<Either<Failure, void>> call({required City city}) async {
    return await weatherRepository.saveCity(city: city);
  }
}
