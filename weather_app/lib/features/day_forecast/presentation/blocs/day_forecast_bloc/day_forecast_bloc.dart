import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/data/datasources/hive_city_data_source.dart';
import 'package:weather_app/features/day_forecast/presentation/blocs/day_forecast_bloc/day_forecast_event.dart';
import 'package:weather_app/features/day_forecast/presentation/blocs/day_forecast_bloc/day_forecast_state.dart';

class DayForecastBloc extends Bloc<DayForecastEvent, DayForecastState> {
  final HiveCityDataSourceImpl _hiveCityDatabaseService;

  DayForecastBloc({required HiveCityDataSourceImpl hiveCityDatabaseService})
    : _hiveCityDatabaseService = hiveCityDatabaseService,
      super(DayForecastPreLoading()) {
    on<DayForecastEvent>(
      (event, emit) => emit(
        DayForecastLoading(
          citiesForDayViewLength: _hiveCityDatabaseService
              .getCitiesForDayViewLength(),
        ),
      ),
    );

    on<DayForecastRefresh>((event, emit) async {
      final citiesForDayView = _hiveCityDatabaseService.getAllCitysDayView();

      emit(
        DayForecastSuccess(
          dayForecastEntityList: await fetchDayForecastList(
            ids: citiesForDayView.map((c) => c.id!).toList(),
            names: citiesForDayView.map((c) => c.name!).toList(),
            lats: citiesForDayView.map((c) => c.lat!).toList(),
            lons: citiesForDayView.map((c) => c.lon!).toList(),
          ),
        ),
      );
    });
  }
}
