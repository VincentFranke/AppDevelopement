import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/enums/view_type.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/weather/domain/entities/city.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';

class GetAllCitiesDayView {
  final WeatherRepository weatherRepository;

  GetAllCitiesDayView({required this.weatherRepository});

  Either<Failure, List<City>> call() {
    Failure? failure;
    final List<City> allCities = [];
    final List<City> allCitiesDayView = [];

    weatherRepository.getAllCities().fold(
      (l) => failure = l,
      (r) => allCities.addAll(r),
    );

    if (failure != null) {
      return left(failure!);
    }

    for (City c in allCities) {
      if (c.viewType! == ViewType.dayView) {
        allCitiesDayView.add(c);
      }
    }

    return right(allCitiesDayView);
  }
}
