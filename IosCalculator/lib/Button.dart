import 'package:IosCalculator/button_type.dart';
import 'package:IosCalculator/state_provider.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Widget buttonSymbol;
  final Color buttonColor;
  final ButtonType buttonType;
  final String? buttonContent;

  Button.icon({
    super.key,
    required IconData iconData,
    required this.buttonColor,
    required this.buttonType,
    this.buttonContent,
  }) : buttonSymbol = Icon(iconData);

  Button.text({
    super.key,
    required String text,
    required this.buttonColor,
    required this.buttonType,
    this.buttonContent,
  }) : buttonSymbol = Text(text);

  @override
  Widget build(BuildContext context) {
    final stateProvider = StateProvider.of(context);
    final VoidCallback? callback;

    switch (buttonType) {
      case ButtonType.delete:
        callback = stateProvider.state.deleteData;
        break;
      case ButtonType.deleteAll:
        callback = stateProvider.state.deleteAll;
        break;
      case ButtonType.calculate:
        callback = stateProvider.state.calculate;
        break;
      case ButtonType.addData:
        callback = () => stateProvider.state.addData(buttonContent!);
        break;
      case ButtonType.doNothing:
        callback = () {};
    }

    return ElevatedButton(
      onPressed: callback,
      style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
      child: buttonSymbol,
    );
  }
}
