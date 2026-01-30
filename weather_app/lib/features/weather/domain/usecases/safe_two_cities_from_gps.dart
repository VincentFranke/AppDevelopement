import 'package:fpdart/fpdart.dart';
import 'package:location/location.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/weather/domain/entities/city.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';

class SafeTwoCitiesFromGps {
  final WeatherRepository weatherRepository;

  SafeTwoCitiesFromGps({required this.weatherRepository});

  Future<Either<Failure, void>> call() async {
    Failure? failure;
    LocationData? locationData;
    List<City>? cities;
    final response = await weatherRepository.getLocationFromGps();

    response.fold((l) => failure = l, (r) => locationData = r);

    if (failure != null) {
      return left(failure!);
    }

    final response2 = await weatherRepository.getTwoCitiesFromCoordinates(
      lat: locationData!.latitude!,
      lon: locationData!.latitude!,
    );

    response2.fold((l) => failure = l, (r) => cities = r);

    if (failure != null) {
      return left(failure!);
    }

    await weatherRepository.saveCity(city: cities!.first);
    return await weatherRepository.saveCity(city: cities!.last);
  }
}
