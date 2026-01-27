import 'package:dart_either/dart_either.dart';
import 'package:weather_app/features/weather/domain/entities/city.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/day_forecast/domain/entities/day_forecast.dart';
import 'package:weather_app/features/day_forecast/domain/repository/day_forecast_repository.dart';

class GetDayForecast {
  final DayForecastRepository dayForecastRepository;

  GetDayForecast({required this.dayForecastRepository});

  Future<Either<List<DayForecast>, Failure>> call() async {
    final List<City> citiesDayView = await dayForecastRepository
        .getCitiesDayView();
    return await dayForecastRepository.getDayForecast();
  }
}
// Bin gerade am gucken ob ich einen oder zwei usecases brauche tendiere eher zu einem, da mich die cityentities im endeffekt nicht interessieren sondern nur 
// da daraus resultierende Ergebnis nähmlich die DayForecast - Entity ggf. aber auch die zwei usecases im bloc aufrufen