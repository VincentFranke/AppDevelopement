abstract class SettingsState {}

class Idle extends SettingsState {}

class Saving extends SettingsState {}

class IsFirstRunSaved extends SettingsState {
  final bool isFirstRun;
  IsFirstRunSaved({required this.isFirstRun});
}
