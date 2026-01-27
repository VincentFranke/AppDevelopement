import 'package:dart_either/dart_either.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/day_forecast/domain/entities/day_forecast.dart';
import 'package:weather_app/features/day_forecast/domain/repository/day_forecast_repository.dart';

class DayForecastRepositoryImpl implements DayForecastRepository{
  final DayForecastRemote
  @override
  Future<Either<List<DayForecast>, Failure>> getDayForecast() {
      List<DayForecast> result = [];

  for (int i = 0; i < names.length; i++) {
    result.add(
      await fetchDayForecastEntity(
        id: ids[i],
        name: names[i],
        lat: lats[i],
        lon: lons[i],
      ),
    );
  }
  }

}