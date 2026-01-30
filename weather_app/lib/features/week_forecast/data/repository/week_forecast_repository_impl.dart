import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/common/entities/city.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/week_forecast/data/datasources/week_forecast_data_source.dart';
import 'package:weather_app/features/week_forecast/domain/entities/week_forecast.dart';
import 'package:weather_app/features/week_forecast/domain/repository/week_forecast_repository.dart';

class WeekForecastRepositoryImpl implements WeekForecastRepository {
  final WeekForecastDataSource weekForecastDataSource;

  WeekForecastRepositoryImpl({required this.weekForecastDataSource});

  @override
  Future<Either<Failure, WeekForecast>> getWeekForecast({
    required City city,
  }) async {
    try {
      final response = await weekForecastDataSource
          .fetchUndetailedDayForecastList(lat: city.lat!, lon: city.lon!);
      return right(
        WeekForecast(
          id: city.id!,
          name: city.name!,
          undetailedDayForecastEntityList: response,
        ),
      );
    } on DataSourceException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
