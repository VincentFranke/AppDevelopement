import 'package:flutter/material.dart';
import 'package:weather_app/logic/day_label.dart';
import 'package:weather_app/logic/entities/day_forecast_entity.dart';
import 'package:weather_app/logic/entities/seven_day_forecast_entity.dart';
import 'package:weather_app/ui/day_forecast_card.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class SevenDayForecastView extends StatelessWidget {
  final SevenDayForecastEntity sevenDayForecastEntity;
  final bool shimmer;
  const SevenDayForecastView({super.key, required this.sevenDayForecastEntity})
    : shimmer = false;
  SevenDayForecastView.shimmer({super.key})
    : sevenDayForecastEntity = SevenDayForecastEntity(
        header: 'Placeholder',
        dayForecastEntityList: [
          DayForecastEntity(
            dayLabel: DayLabel.monday,
            temperature: -100,
            weatherCode: -100,
          ),
        ],
      ),
      shimmer = true;

  @override
  Widget build(BuildContext context) {
    final headerContent = Text(
      sevenDayForecastEntity.header,
      style: Theme.of(context).textTheme.titleMedium,
    );
    final headerContentShimmer =

    return Column(
      children: [
        ColoredBox(
          color: Colors.blue.withValues(alpha: 0.5),
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child: Align(alignment: Alignment.centerLeft, child: headerContent),
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
