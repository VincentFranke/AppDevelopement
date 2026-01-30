import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/common/entities/city.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/week_forecast/domain/entities/week_forecast.dart';
import 'package:weather_app/features/week_forecast/domain/repository/week_forecast_repository.dart';

class GetWeekForecast {
  final WeekForecastRepository weekForecastRepository;

  GetWeekForecast({required this.weekForecastRepository});

  Future<Either<Failure, WeekForecast>> call({required City city}) async {
    return await weekForecastRepository.getWeekForecast(city: city);
  }
}
