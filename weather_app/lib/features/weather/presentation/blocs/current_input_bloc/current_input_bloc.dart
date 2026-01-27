import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/data/datasources/location_data_source.dart';
import 'package:weather_app/features/weather/presentation/blocs/current_input_bloc/current_input_bloc_events.dart';
import 'package:weather_app/features/weather/presentation/blocs/current_input_bloc/current_input_bloc_state.dart';
import 'package:weather_app/features/weather/domain/entities/city.dart';

class CurrentInputBloc
    extends Bloc<CurrentInputBlocEvents, CurrentInputBlocState> {
  CurrentInputBloc()
    : super(CurrentInputBlocState(citySuggestions: [], currentInput: '')) {
    on<CurrentInputChangedEvent>((event, emit) async {
      final List<City> result = await fetchFiveCitySuggestions(
        currentInput: event.currentInput,
        viewType: event.viewType,
      );

      emit(
        CurrentInputBlocState(
          citySuggestions: result,
          currentInput: event.currentInput,
        ),
      );
    });
  }
}
