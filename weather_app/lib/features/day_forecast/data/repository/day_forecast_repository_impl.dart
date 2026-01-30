import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/day_forecast/data/datasources/day_forecast_remote_datasource.dart';
import 'package:weather_app/features/day_forecast/domain/entities/day_forecast.dart';
import 'package:weather_app/features/day_forecast/domain/repository/day_forecast_repository.dart';
import 'package:weather_app/features/weather/domain/entities/city.dart';

class DayForecastRepositoryImpl implements DayForecastRepository {
  final DayForecastRemoteDatasource dayForecastRemoteDatasource;

  DayForecastRepositoryImpl({required this.dayForecastRemoteDatasource});

  @override
  Future<Either<Failure, DayForecast>> getDayForecast({
    required City city,
  }) async {
    try {
      final hourlyForecastList = await dayForecastRemoteDatasource
          .fetchHourlyForecastList(
            name: city.name!,
            lat: city.lat!,
            lon: city.lon!,
          );

      final dayForecastRemote = await dayForecastRemoteDatasource
          .fetchDayForecastRemote(
            id: city.id!,
            name: city.name!,
            lat: city.lat!,
            lon: city.lon!,
          );

      return right(
        DayForecast(
          id: city.id!,
          name: city.name!,
          sunrise: dayForecastRemote.sunrise,
          sunset: dayForecastRemote.sunset,
          timeZone: dayForecastRemote.timeZone,
          hourlyForecastList: hourlyForecastList,
        ),
      );
    } on DataSourceException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
