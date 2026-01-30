import 'package:fpdart/fpdart.dart';
import 'package:location/location.dart';
import 'package:weather_app/core/enums/view_type.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/weather/domain/entities/city.dart';

abstract interface class WeatherRepository {
  Either<Failure, List<City>> getAllCities();

  Future<Either<Failure, List<City>>> getFiveCitySuggestions({
    required String currentInput,
    required ViewType viewType,
  });

  Future<Either<Failure, LocationData>> getLocationFromGps();

  Future<Either<Failure, void>> saveCity({required City city});

  Future<Either<Failure, List<City>>> getTwoCitiesFromCoordinates({
    required double lat,
    required double lon,
  });
}
