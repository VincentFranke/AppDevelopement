import 'package:flutter/material.dart';

class UndetailedDayForecastCardSkeleton extends StatelessWidget {
  final Widget? child;
  const UndetailedDayForecastCardSkeleton({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(child: child);
  }
}
