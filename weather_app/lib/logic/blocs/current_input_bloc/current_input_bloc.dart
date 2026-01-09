import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/database/location_api_client.dart';
import 'package:weather_app/logic/blocs/current_input_bloc/current_input_bloc_events.dart';
import 'package:weather_app/logic/blocs/current_input_bloc/current_input_bloc_state.dart';
import 'package:weather_app/logic/entities/city_entity.dart';

class CurrentInputBloc
    extends Bloc<CurrentInputBlocEvents, CurrentInputBlocState> {
  CurrentInputBloc()
    : super(CurrentInputBlocState(citySuggestions: [], currentInput: '')) {
    on<CurrentInputChangedEvent>((event, emit) async {
      final List<CityEntity> result = await fetchCitySuggestions(
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
