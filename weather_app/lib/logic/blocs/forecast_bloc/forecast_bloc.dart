import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/database/hive_city_database_service.dart';
import 'package:weather_app/database/weather_api_client.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc_events.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc_states.dart';
import 'package:weather_app/logic/entities/city_entity.dart';
import 'package:weather_app/logic/entities/seven_day_forecast_entity.dart';

class ForecastBloc extends Bloc<ForecastBlocEvent, ForecastStates> {
  final HiveCityDatabaseService hiveCityDatabaseService;
  ForecastBloc()
    : hiveCityDatabaseService = HiveCityDatabaseService(),
      super(DisplayForecastPreLoadingScreenState()) {
    on<HomePageRefreshEvent>((event, emit) async {
      emit(
        DisplayForecastLoadingScreenState(
          citysToDisplayCount: hiveCityDatabaseService.getCityLength(),
        ),
      );
      emit(
        DisplayForecastDataState(
          sevenDayForecastEntityList: await _getCurrentSevenDayForecastData(),
        ),
      );
    });
    on<AddCityEvent>((event, emit) async {
      emit(
        DisplayForecastLoadingScreenState(
          citysToDisplayCount: hiveCityDatabaseService.getCityLength(),
        ),
      );
      hiveCityDatabaseService.addCity(
        name: event.cityEntity.name!,
        json: event.cityEntity.toJson(),
      );
      emit(
        DisplayForecastDataState(
          sevenDayForecastEntityList: await _getCurrentSevenDayForecastData(),
        ),
      );
    });
  }

  Future<List<SevenDayForecastEntity>> _getCurrentSevenDayForecastData() async {
    final List<Map<String, dynamic>> citysJson = hiveCityDatabaseService
        .getAllCitys();
    final List<CityEntity> cities = [];

    for (Map<String, dynamic> cityJson in citysJson) {
      cities.add(CityEntity.fromJson(jsonData: cityJson));
    }

    return fetchSevenDayForecastList(
      cities.map((c) => c.name!).toList(),
      cities.map((c) => c.lat!).toList(),
      cities.map((c) => c.lon!).toList(),
    );
  }
}
