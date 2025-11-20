import 'package:flutter/material.dart';
import 'package:weather_app/database/hive_city_database_service.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc_events.dart';
import 'package:weather_app/logic/day_label.dart';
import 'package:weather_app/logic/entities/day_forecast_entity.dart';
import 'package:weather_app/logic/entities/seven_day_forecast_entity.dart';
import 'package:weather_app/ui/day_forecast_card.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:weather_app/ui/detailed_day_forecast_screen.dart';

class SevenDayForecastView extends StatelessWidget {
  final SevenDayForecastEntity sevenDayForecastEntity;
  final ForecastBloc forecastBloc;
  final bool shimmer;
  const SevenDayForecastView({
    super.key,
    required this.sevenDayForecastEntity,
    required this.forecastBloc,
  }) : shimmer = false;
  SevenDayForecastView.shimmer({super.key, required this.forecastBloc})
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
    return Column(
      children: [
        shimmer
            ? _shimmerWrap(
                child: ColoredBox(
                  color: Colors.blue.withValues(alpha: 0.5),
                  child: SizedBox(height: 40, width: double.infinity),
                ),
              )
            : ColoredBox(
                color: Colors.blue.withValues(alpha: 0.5),
                child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        sevenDayForecastEntity.header,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return DetailedDayForecastScreen(
                                      header: sevenDayForecastEntity.header,
                                    );
                                  },
                                ),
                              );
                            },
                            icon: Icon(Icons.area_chart),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          HiveCityDatabaseService().deleteCity(
                            name: sevenDayForecastEntity.header,
                          );
                          forecastBloc.add(HomePageRefreshEvent());
                        },
                        icon: Icon(Icons.remove),
                      ),
                    ],
                  ),
                ),
              ),
        SizedBox(
          height: 200,
          child: CarouselView(
            scrollDirection: Axis.horizontal,
            itemExtent: 200,
            children: shimmer
                ? List.generate(7, (_) => _shimmerWrap(child: Card()))
                : sevenDayForecastEntity.dayForecastEntityList
                      .map((day) => DayForecastCard(dayForecastEntity: day))
                      .toList(),
          ),
        ),
      ],
    );
  }

  Widget _shimmerWrap({required Widget child}) {
    return Shimmer(duration: Duration(milliseconds: 1500), child: child);
  }
}
