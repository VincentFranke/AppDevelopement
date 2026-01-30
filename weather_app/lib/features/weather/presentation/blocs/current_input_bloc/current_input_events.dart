import 'package:weather_app/core/enums/view_type.dart';

abstract class CurrentInputEvents {}

class CurrentInputChanged extends CurrentInputEvents {
  final String currentInput;
  final ViewType viewType;

  CurrentInputChanged({required this.currentInput, required this.viewType});
}
