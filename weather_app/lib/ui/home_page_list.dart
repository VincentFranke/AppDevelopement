import 'package:flutter/material.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc_states.dart';
import 'package:weather_app/ui/day_forecast_line_chart/day_forecast_line_chart_body.dart';
import 'package:weather_app/ui/day_forecast_line_chart/day_forecast_line_chart_skeleton.dart';
import 'package:weather_app/ui/header_card/header_card_body.dart';
import 'package:weather_app/ui/header_card/header_card_skeleton.dart';
import 'package:weather_app/ui/week_forecast_view/undetailed_day_forecast_card/undetailed_day_forecast_card_body.dart';
import 'package:weather_app/ui/week_forecast_view/undetailed_day_forecast_card/undetailed_day_forecast_card_skeleton.dart';
import 'package:weather_app/ui/week_forecast_view/week_forecast_view.dart';

class HomePageList extends StatelessWidget {
  final ForecastBloc forecastBloc;
  final DisplayForecastDataState forecastState;
  const HomePageList({
    super.key,
    required this.forecastBloc,
    required this.forecastState,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount:
          forecastState.dayForecastEntityList.length +
          forecastState.weekForecastEntityList.length,
      itemBuilder: (context, index) {
        if (index <= forecastState.dayForecastEntityList.length - 1) {
          return Column(
            children: [
              HeaderCardSkeleton(
                child: HeaderCardBody(
                  id: forecastState.dayForecastEntityList[index].id,
                  name: forecastState.dayForecastEntityList[index].name,
                  forecastBloc: forecastBloc,
                ),
              ),
              DayForecastLineChartSkeleton(
                child: DayForecastLineChartBody(
                  dayEntity: forecastState.dayForecastEntityList[index],
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              HeaderCardSkeleton(
                child: HeaderCardBody(
                  id: forecastState
                      .weekForecastEntityList[index -
                          forecastState.dayForecastEntityList.length]
                      .id,
                  name: forecastState
                      .weekForecastEntityList[index -
                          forecastState.dayForecastEntityList.length]
                      .name,
                  forecastBloc: forecastBloc,
                ),
              ),
              WeekForecastView(
                children: List.generate(
                  forecastState
                      .weekForecastEntityList[index -
                          forecastState.dayForecastEntityList.length]
                      .undetailedDayForecastEntityList
                      .length,
                  (index2) => UndetailedDayForecastCardSkeleton(
                    child: UndetailedDayForecastCardBody(
                      undetailedDayForecastEntity: forecastState
                          .weekForecastEntityList[index -
                              forecastState.dayForecastEntityList.length]
                          .undetailedDayForecastEntityList[index2],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
