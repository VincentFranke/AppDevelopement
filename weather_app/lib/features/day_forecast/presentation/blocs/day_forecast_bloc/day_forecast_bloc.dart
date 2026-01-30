import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/day_forecast/domain/usecases/get_day_forecast.dart';
import 'package:weather_app/features/day_forecast/presentation/blocs/day_forecast_bloc/day_forecast_event.dart';
import 'package:weather_app/features/day_forecast/presentation/blocs/day_forecast_bloc/day_forecast_state.dart';

class DayForecastBloc extends Bloc<DayForecastEvent, DayForecastState> {
  final GetDayForecast _getDayForecast;

  DayForecastBloc({required GetDayForecast getDayForecast})
    : _getDayForecast = getDayForecast,
      super(DayForecastLoading()) {
    on<DayForecastRequestRefresh>((event, emit) async {
      emit(DayForecastLoading());

      final response = await _getDayForecast(city: event.city);

      response.fold(
        (l) => emit(DayForecastError(message: l.message)),
        (r) => emit(DayForecastSuccess(dayForecast: r)),
      );
    });
  }
}
