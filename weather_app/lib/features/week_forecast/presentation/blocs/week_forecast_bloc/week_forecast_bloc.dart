import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/data/datasources/hive_city_data_source.dart';
import 'package:weather_app/features/week_forecast/presentation/blocs/week_forecast_bloc/week_forecast_events.dart';
import 'package:weather_app/features/week_forecast/presentation/blocs/week_forecast_bloc/week_forecast_states.dart';

class WeekForecastBloc extends Bloc<WeekForecastEvents, WeekForecastStates> {
  WeekForecastBloc() : super(WeekForecastPreLoading()) {
    on<WeekForecastEvents>(
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
  }
}
