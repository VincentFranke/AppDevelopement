import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/common/entities/city.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/week_forecast/data/datasources/week_forecast_data_source.dart';
import 'package:weather_app/features/week_forecast/domain/entities/undetailed_day_forecast_entity.dart';
import 'package:weather_app/features/week_forecast/domain/entities/week_forecast.dart';
import 'package:weather_app/features/week_forecast/domain/repository/week_forecast_repository.dart';

class WeekForecastRepositoryImpl implements WeekForecastRepository {
  final WeekForecastDataSource weekForecastDataSource;

  WeekForecastRepositoryImpl({required this.weekForecastDataSource});

  @override
  Future<Either<Failure, WeekForecast>> getWeekForecast({
    required City city,
  }) async {
    // Bin hier gerade am machen sodass eben nur ein WeekForecast zurückgegeben wird -> features sollen einzeln 
    try{
      return right(await weekForecastDataSource.fetchUndetailedDayForecastList(lat: lat, lon: lon))
    } on DataSourceException catch{

    }

    return right(result);
  }
}
