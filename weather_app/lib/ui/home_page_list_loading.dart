import 'package:flutter/material.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc_states.dart';
import 'package:weather_app/ui/day_forecast_line_chart/day_forecast_line_chart_skeleton.dart';
import 'package:weather_app/ui/header_card/header_card_skeleton.dart';
import 'package:weather_app/ui/reusable/shimmer_wrapper.dart';
import 'package:weather_app/ui/week_forecast_view/undetailed_day_forecast_card/undetailed_day_forecast_card_skeleton.dart';
import 'package:weather_app/ui/week_forecast_view/week_forecast_view.dart';

class HomePageListLoading extends StatelessWidget {
  final DisplayForecastLoadingScreenState forecastState;
  const HomePageListLoading({super.key, required this.forecastState});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount:
          forecastState.numberOfCitiesDesignatedForDayView +
          forecastState.numberOfCitiesDesignatedForWeekView,
      itemBuilder: (context, index) {
        if (index <= forecastState.numberOfCitiesDesignatedForDayView - 1) {
          return Column(
            children: [
              ShimmerWrapper(
                applyShimmer: true,
                skeleton: (child) => HeaderCardSkeleton(child: child),
              ),
              ShimmerWrapper(
                applyShimmer: true,
                skeleton: (child) => DayForecastLineChartSkeleton(child: child),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              ShimmerWrapper(
                applyShimmer: true,
                skeleton: (child) => HeaderCardSkeleton(child: child),
              ),
              WeekForecastView(
                children: List.generate(
                  7,
                  (index2) => ShimmerWrapper(
                    applyShimmer: true,
                    skeleton: ((child) =>
                        UndetailedDayForecastCardSkeleton(child: child)),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
    ;
  }
}
