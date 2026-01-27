import 'package:weather_app/core/enums/view_type.dart';

abstract class CurrentInputBlocEvents {}

class CurrentInputChangedEvent extends CurrentInputBlocEvents {
  final String currentInput;
  final ViewType viewType;
  CurrentInputChangedEvent({
    required this.currentInput,
    required this.viewType,
  });
}
