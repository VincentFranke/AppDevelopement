import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/shared_preferences_service.dart';
import 'package:weather_app/core/common/blocs/settings_bloc/settings_event.dart';
import 'package:weather_app/core/common/blocs/settings_bloc/settings_bloc_states.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(Idle()) {
    on<SettingsSaveIsFirstRun>((event, emit) async {
      emit(Saving());

      final isFirstRun = await SharedPreferencesService().isFirstRun();

      emit(IsFirstRunSaved(isFirstRun: isFirstRun));
    });
  }
}
