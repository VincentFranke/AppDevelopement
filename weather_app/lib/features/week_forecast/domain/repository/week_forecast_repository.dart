import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/common/entities/city.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/week_forecast/domain/entities/week_forecast.dart';

abstract interface class WeekForecastRepository {
  Future<Either<Failure, WeekForecast>> getWeekForecast({
    required List<City> cities,
  });
}
