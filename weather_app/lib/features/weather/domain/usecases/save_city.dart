import 'package:dart_either/dart_either.dart';
import 'package:weather_app/features/weather/domain/entities/city.dart';
import 'package:weather_app/core/error/failure.dart';

class SaveCity {
  Either<Failure, void> call({required City cityEntity}) {}
}
