import 'package:flutter/material.dart';

class WeekForecastView extends StatelessWidget {
  final List<Widget> children;
  const WeekForecastView({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CarouselView(
        scrollDirection: Axis.horizontal,
        itemExtent: 200,
        backgroundColor: Colors.blueGrey,
        children: children,
      ),
    );
  }
}
