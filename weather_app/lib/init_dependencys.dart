import 'package:get_it/get_it.dart';
import 'package:weather_app/core/common/blocs/settings_bloc/settings_bloc.dart';
import 'package:weather_app/features/day_forecast/presentation/blocs/day_forecast_bloc/day_forecast_bloc.dart';
import 'package:weather_app/features/weather/presentation/blocs/current_input_bloc/current_input_bloc.dart';
import 'package:weather_app/features/weather/presentation/blocs/get_location_bloc/get_location_bloc.dart';
import 'package:weather_app/features/weather/presentation/blocs/view_type_bloc/view_type_bloc.dart';
import 'package:weather_app/features/week_forecast/presentation/blocs/week_forecast_bloc/week_forecast_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencys() async {
  _initCore();
  _initDayForecast();
  _initWeekForecast();
  _initWeather();
}

void _initCore(){
    serviceLocator.registerLazySingleton(() => SettingsBloc());

}

void _initDayForecast() {
  serviceLocator
    ..registerLazySingleton(() => GetLocationBloc())
    ..registerLazySingleton(() => DayForecastBloc());
}

void _initWeekForecast() {
    serviceLocator.registerLazySingleton(() => WeekForecastBloc());
}

void _initWeather(){
    serviceLocator
    ..registerLazySingleton(() => CurrentInputBloc())
    ..registerLazySingleton(() => ViewTypeBloc());

}
