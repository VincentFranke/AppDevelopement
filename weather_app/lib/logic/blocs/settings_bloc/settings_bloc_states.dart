abstract class SettingsBlocStates {}

class IdleState extends SettingsBlocStates {}

class SavingState extends SettingsBlocStates {}

class IsFirstRunSavedState extends SettingsBlocStates {
  final bool isFirstRun;
  IsFirstRunSavedState({required this.isFirstRun});
}
