import 'package:IosCalculator/StateProvider.dart';
import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  const Display({super.key});

  @override
  Widget build(BuildContext context) {
    final stateProvider = StateProvider.of(context);
    return Text(stateProvider.state.currentCalculation,
    textAlign: TextAlign.right,
    style: Theme.of(context).textTheme.bodyMedium);
  }
}
