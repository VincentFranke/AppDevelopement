import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/database/shared_preferences_service.dart';
import 'package:weather_app/logic/blocs/settings_bloc/settings_bloc_events.dart';
import 'package:weather_app/logic/blocs/settings_bloc/settings_bloc_states.dart';

class SettingsBloc extends Bloc<SettingsBlocEvents, SettingsBlocStates> {
  SettingsBloc() : super(IdleState()) {
    on<SaveIsFirstRunEvent>((event, emit) async {
      emit(SavingState());

      final isFirstRun = await SharedPreferencesService().isFirstRun();

      emit(IsFirstRunSavedState(isFirstRun: isFirstRun));
    });
  }
}
