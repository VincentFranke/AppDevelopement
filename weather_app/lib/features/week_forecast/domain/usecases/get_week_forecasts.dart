import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/common/entities/city.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/week_forecast/domain/entities/week_forecast.dart';
import 'package:weather_app/features/week_forecast/domain/repository/week_forecast_repository.dart';

class GetWeekForecasts {
  final WeekForecastRepository weekForecastRepository;

  GetWeekForecasts({required this.weekForecastRepository});

  Future<Either<Failure, List<WeekForecast>>> call({
    required List<City> cities,
  }) async {
    return await weekForecastRepository.getWeekForecast(cities: cities);
  }
}
