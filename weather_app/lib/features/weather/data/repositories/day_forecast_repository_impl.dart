import 'package:weather_app/features/weather/data/datasources/gps_data_source.dart';
import 'package:weather_app/features/weather/data/datasources/location_data_source.dart';

class DayForecastRepositoryImpl {
  final LocationDataSourceImpl locationDataSource;
  final GpsDataSourceImpl gpsDataSource;

  DayForecastRepositoryImpl({required this.locationDataSource, required this.gpsDataSource});

  void getCityFromInput(){}

  void getCityFromGps(){}

  void add
}