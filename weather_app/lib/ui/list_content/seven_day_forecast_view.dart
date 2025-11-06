import 'package:flutter/material.dart';
import 'package:weather_app/ui/list_content/day_forecast_card.dart';

class SevenDayForecastView extends StatelessWidget {
  final List<DayForecastCard> days;
  const SevenDayForecastView({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CarouselView(
        scrollDirection: Axis.horizontal,
        itemExtent: 200,
        children: days,
      ),
    );
  }
}
