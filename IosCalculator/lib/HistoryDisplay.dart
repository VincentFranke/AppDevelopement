import 'package:IosCalculator/StateProvider.dart';
import 'package:flutter/material.dart';

class HistoryDisplay extends StatelessWidget {
  const HistoryDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final stateProvider = StateProvider.of(context);
    return Text(stateProvider.state.previousCalculation,
    textAlign: TextAlign.right,
    style: Theme.of(context).textTheme.bodySmall);
  }
}
