import 'package:flutter/material.dart';
import 'package:weather_app/logic/entities/seven_day_forecast_entity.dart';
import 'package:weather_app/ui/day_forecast_card.dart';

class SevenDayForecastView extends StatelessWidget {
  final SevenDayForecastEntity sevenDayForecastEntity;
  const SevenDayForecastView({super.key, required this.sevenDayForecastEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColoredBox(
          color: Colors.blue.withValues(alpha: 0.5),
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                sevenDayForecastEntity.header,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: CarouselView(
            scrollDirection: Axis.horizontal,
            itemExtent: 200,
            children: sevenDayForecastEntity.dayForecastEntityList
                .map((day) => DayForecastCard(dayForecastEntity: day))
                .toList(),
          ),
        ),
      ],
    );
  }
}
