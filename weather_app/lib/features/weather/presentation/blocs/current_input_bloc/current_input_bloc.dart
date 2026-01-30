import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/domain/usecases/get_five_city_suggestions.dart';
import 'package:weather_app/features/weather/presentation/blocs/current_input_bloc/current_input_events.dart';
import 'package:weather_app/features/weather/presentation/blocs/current_input_bloc/current_input_state.dart';

class CurrentInputBloc extends Bloc<CurrentInputEvents, CurrentInputState> {
  final GetFiveCitySuggestions _getFiveCitySuggestions;

  CurrentInputBloc({required GetFiveCitySuggestions getFiveCitySuggestions})
    : _getFiveCitySuggestions = getFiveCitySuggestions,
      super(RequestSuccessfull(citySuggestions: [], currentInput: '')) {
    on<CurrentInputChanged>((event, emit) async {
      final response = await _getFiveCitySuggestions(
        currentInput: event.currentInput,
        viewType: event.viewType,
      );

      response.fold(
        (l) => emit(RequestFailed(message: l.message)),
        (r) => emit(
          RequestSuccessfull(
            currentInput: event.currentInput,
            citySuggestions: r,
          ),
        ),
      );
    });
  }
}
