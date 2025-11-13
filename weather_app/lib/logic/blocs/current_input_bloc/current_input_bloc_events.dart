abstract class CurrentInputBlocEvents {}

class InputChangedEvent extends CurrentInputBlocEvents {
  final String currentInput;
  InputChangedEvent({required this.currentInput});
}
