import 'package:flutter/widgets.dart';

class LineChartTempYAxis extends StatelessWidget {
  final int minYToDisplay;
  final int maxYToDisplay;
  final String unit;
  late final List<Text> labels = [];

  LineChartTempYAxis({
    super.key,
    required int minY,
    required int maxY,
    required this.unit,
  }) : minYToDisplay = minY + 1,
       maxYToDisplay = maxY - 1 {
    for (int i = maxYToDisplay; i >= minYToDisplay; i--) {
      labels.add(Text(i.toString() + unit));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: labels,
    );
  }
}
