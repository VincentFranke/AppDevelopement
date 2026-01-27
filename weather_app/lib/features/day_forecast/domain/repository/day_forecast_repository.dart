import 'package:weather_app/features/weather/domain/entities/city.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/day_forecast/domain/entities/day_forecast.dart';
import 'package:dart_either/dart_either.dart';

abstract interface class DayForecastRepository {
  Future<Either<List<DayForecast>, Failure>> getDayForecast();

  Future<Either<List<City>, Failure>> getCitiesDayView();
}
