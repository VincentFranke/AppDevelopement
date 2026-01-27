import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/domain/entities/city.dart';
import 'package:weather_app/core/common/entities/week_forecast_entity.dart';
import 'package:weather_app/core/enums/view_type.dart';
import 'package:weather_app/features/weather/data/datasources/hive_city_data_source.dart';
import 'package:weather_app/features/week_forecast/data/datasources/week_forecast_remote_datasource.dart';
import 'package:weather_app/features/week_forecast/presentation/blocs/week_forecast_bloc/week_forecast_event.dart';
import 'package:weather_app/features/week_forecast/presentation/blocs/week_forecast_bloc/week_forecast_state.dart';

class WeekForecastBloc extends Bloc<WeekForecastEvent, WeekForecastState> {
  final HiveCityDataSourceImpl hiveCityDatabaseService;
  WeekForecastBloc()
    : hiveCityDatabaseService = HiveCityDataSourceImpl(),
      super(WeekForecastPreLoading()) {
    on<WeekForecastEvent>(
      (event, emit) => emit(
        WeekForecastLoading(
          numberOfCitiesDesignatedForDayView: hiveCityDatabaseService
              .getCitiesForDayViewLength(),
          numberOfCitiesDesignatedForWeekView: hiveCityDatabaseService
              .getCitiesForWeekViewLength(),
        ),
      ),
    );
    on<WeekForecastRefresh>((event, emit) async {
      emit(
        WeekForecastSuccess(
          weekForecastEntityList: await _getCurrentWeekForecastData(),
          dayForecastEntityList: await _getCurrentDayForecastData(),
          bothViewsAlreadyExist: false,
        ),
      );
    });
    on<WeekForecastAddCity>((event, emit) async {
      final viewAlreadyExists = await hiveCityDatabaseService.addCity(
        name: event.cityEntity.name!,
        json: event.cityEntity.toInternalJson(),
      );
      emit(
        WeekForecastSuccess(
          weekForecastEntityList: await _getCurrentWeekForecastData(),
          dayForecastEntityList: await _getCurrentDayForecastData(),
          bothViewsAlreadyExist: viewAlreadyExists,
        ),
      );
    });
    on<WeekForecastAddMultipleCitys>((event, emit) async {
      final viewAlreadyExistsDayView = await hiveCityDatabaseService.addCity(
        name: event.citysAndViewTypes.keys.first.name!,
        json: event.citysAndViewTypes.entries.first.key.toInternalJson(),
      );
      final viewAlreadyExistsWeekView = await hiveCityDatabaseService.addCity(
        name: event.citysAndViewTypes.keys.last.name!,
        json: event.citysAndViewTypes.entries.last.key.toInternalJson(),
      );
      final bothViewsAlreadyExist =
          viewAlreadyExistsDayView && viewAlreadyExistsWeekView;

      emit(
        WeekForecastSuccess(
          weekForecastEntityList: await _getCurrentWeekForecastData(),
          dayForecastEntityList: await _getCurrentDayForecastData(),
          bothViewsAlreadyExist: bothViewsAlreadyExist,
        ),
      );
    });
  }

  Future<List<WeekForecastEntity>> _getCurrentWeekForecastData() async {
    final List<City> citys = hiveCityDatabaseService.getAllCitys();
    final List<City> citiesDesignatedForWeekView = [];

    for (City city in citys) {
      if (city.viewType == ViewType.weekView) {
        citiesDesignatedForWeekView.add(city);
      }
    }

    return fetchWeekForecastEntityList(
      names: citiesDesignatedForWeekView.map((c) => c.name!).toList(),
      ids: citiesDesignatedForWeekView.map((c) => c.id!).toList(),
      lats: citiesDesignatedForWeekView.map((c) => c.lat!).toList(),
      lons: citiesDesignatedForWeekView.map((c) => c.lon!).toList(),
    );
  }
}
