import 'package:fpdart/fpdart.dart';
import 'package:location/location.dart';
import 'package:weather_app/core/enums/view_type.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/weather/data/datasources/gps_data_source.dart';
import 'package:weather_app/features/weather/data/datasources/hive_city_data_source.dart';
import 'package:weather_app/features/weather/data/datasources/location_data_source.dart';
import 'package:weather_app/features/weather/data/models/city_model.dart';
import 'package:weather_app/features/weather/domain/entities/city.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final GpsDataSourceImpl gpsDataSource;
  final HiveCityDataSource hiveCityDataSource;
  final LocationDataSource locationDataSource;

  WeatherRepositoryImpl({
    required this.gpsDataSource,
    required this.hiveCityDataSource,
    required this.locationDataSource,
  });

  @override
  Either<Failure, List<City>> getAllCities() {
    try {
      return right(hiveCityDataSource.getAllCities());
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<City>>> getFiveCitySuggestions({
    required String currentInput,
    required ViewType viewType,
  }) async {
    try {
      return right(
        await locationDataSource.fetchFiveCitySuggestions(
          currentInput: currentInput,
          viewType: viewType,
        ),
      );
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocationData>> getLocationFromGps() async {
    try {
      return right(await gpsDataSource.tryFetchLocation());
    } on DataSourceException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveCity({required City city}) async {
    final CityModel cityModel = city as CityModel;
    try {
      return right(
        await hiveCityDataSource.saveCity(
          id: cityModel.id!,
          internalJson: cityModel.toInternalJson(),
        ),
      );
    } on DataSourceException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<City>>> getTwoCitiesFromCoordinates({
    required double lat,
    required double lon,
  }) async {
    try {
      final baseCity = await locationDataSource.fetchCityFromCoordinates(
        lat: lat,
        lon: lon,
      );
      return right([
        baseCity.copyWith(viewType: ViewType.dayView),
        baseCity.copyWith(viewType: ViewType.weekView),
      ]);
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
