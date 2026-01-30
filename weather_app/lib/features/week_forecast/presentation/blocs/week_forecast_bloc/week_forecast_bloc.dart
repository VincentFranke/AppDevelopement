import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/week_forecast/domain/usecases/get_week_forecast.dart';
import 'package:weather_app/features/week_forecast/presentation/blocs/week_forecast_bloc/week_forecast_events.dart';
import 'package:weather_app/features/week_forecast/presentation/blocs/week_forecast_bloc/week_forecast_states.dart';

class WeekForecastBloc extends Bloc<WeekForecastEvents, WeekForecastStates> {
  final GetWeekForecast _getWeekForecast;

  WeekForecastBloc({required GetWeekForecast getWeekForecast})
    : _getWeekForecast = getWeekForecast,
      super(WeekForecastLoading()) {
    on<WeekForecastRefreshRequest>((event, emit) async {
      emit(WeekForecastLoading());

      final response = await _getWeekForecast(city: event.city);

      response.fold(
        (l) => emit(WeekForecastError(message: l.message)),
        (r) => emit(WeekForecastSuccess(weekForecast: r)),
      );
    });
  }
}
