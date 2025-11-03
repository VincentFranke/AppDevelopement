import 'package:IosCalculator/state_provider.dart';
import 'package:flutter/material.dart';

class HistoryResultContainer extends StatelessWidget {
  const HistoryResultContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final stateProvider = StateProvider.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: Text(
        textHeightBehavior: TextHeightBehavior(
          applyHeightToFirstAscent: false,
          applyHeightToLastDescent: false,
        ),
        stateProvider.state.previousCalculation,
        textAlign: TextAlign.right,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
