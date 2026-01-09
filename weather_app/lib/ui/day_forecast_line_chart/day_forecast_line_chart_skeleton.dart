import 'package:flutter/material.dart';

class DayForecastLineChartSkeleton extends StatelessWidget {
  final Widget? child;
  const DayForecastLineChartSkeleton({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 250, width: double.infinity, child: child);
  }
}
