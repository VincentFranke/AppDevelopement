import 'package:IosCalculator/state_provider.dart';
import 'package:flutter/material.dart';

class ResultContainer extends StatelessWidget {
  const ResultContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final stateProvider = StateProvider.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      controller: stateProvider.state.scrollController,
      child: Text(
        textHeightBehavior: TextHeightBehavior(
          applyHeightToFirstAscent: false,
          applyHeightToLastDescent: false,
        ),
        stateProvider.state.currentCalculation,
        textAlign: TextAlign.right,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
