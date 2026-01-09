import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/logic/blocs/current_input_bloc/current_input_bloc.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc_events.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc_states.dart';
import 'package:weather_app/logic/blocs/view_type_bloc/view_type_bloc.dart';
import 'package:weather_app/logic/city_suggestion_card_layout_config.dart';
import 'package:weather_app/ui/add_city_page/add_city_page.dart';
import 'package:weather_app/ui/day_forecast_line_chart/day_forecast_line_chart_skeleton.dart';
import 'package:weather_app/ui/header_card/header_card_body.dart';
import 'package:weather_app/ui/header_card/header_card_skeleton.dart';
import 'package:weather_app/ui/day_forecast_line_chart/day_forecast_line_chart_body.dart';
import 'package:weather_app/ui/reusable/shimmer_wrapper.dart';
import 'package:weather_app/ui/week_forecast_view/undetailed_day_forecast_card/undetailed_day_forecast_card_body.dart';
import 'package:weather_app/ui/week_forecast_view/undetailed_day_forecast_card/undetailed_day_forecast_card_skeleton.dart';
import 'package:weather_app/ui/week_forecast_view/week_forecast_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final forecastBloc = context.read<ForecastBloc>();
    final currentInputBloc = context.read<CurrentInputBloc>();
    final viewTypeBloc = context.read<ViewTypeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
        actions: [
          IconButton(
            iconSize: 50,
            onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.red,
              context: context,
              builder: (context) => AddCityPage(
                citySuggestionCardLayoutConfig: CitySuggestionCardLayoutConfig(
                  padding: 5,
                  countryCodeFlexValue: 1,
                  countryFlexValue: 3,
                  nameFlexValue: 2,
                  federalStateFlexValue: 4,
                ),
                currentInputBloc: currentInputBloc,
                forecastBloc: forecastBloc,
                viewTypeBloc: viewTypeBloc,
              ),
            ),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          forecastBloc.add(HomePageRefreshEvent());
        },
        child: SizedBox.expand(
          child: BlocBuilder<ForecastBloc, ForecastStates>(
            builder: (context, state) {
              if (state is DisplayForecastPreLoadingScreenState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is DisplayForecastLoadingErrorState) {
                return Center(child: Text(AppLocalizations.of(context)!.error));
              } else if (state is DisplayForecastLoadingScreenState) {
                // Normaler Loading-Screen
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      state.numberOfCitiesDesignatedForDayView +
                      state.numberOfCitiesDesignatedForWeekView,
                  itemBuilder: (context, index) {
                    if (index <= state.numberOfCitiesDesignatedForDayView - 1) {
                      return Column(
                        children: [
                          ShimmerWrapper(
                            applyShimmer: true,
                            skeleton: (child) =>
                                HeaderCardSkeleton(child: child),
                          ),
                          ShimmerWrapper(
                            applyShimmer: true,
                            skeleton: (child) =>
                                DayForecastLineChartSkeleton(child: child),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          ShimmerWrapper(
                            applyShimmer: true,
                            skeleton: (child) =>
                                HeaderCardSkeleton(child: child),
                          ),
                          WeekForecastView(
                            children: List.generate(
                              7,
                              (index2) => ShimmerWrapper(
                                applyShimmer: true,
                                skeleton: ((child) =>
                                    UndetailedDayForecastCardSkeleton(
                                      child: child,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              } else if (state is DisplayForecastDataState) {
                // Anzeigen von Daten
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      state.dayForecastEntityList.length +
                      state.weekForecastEntityList.length,
                  itemBuilder: (context, index) {
                    if (index <= state.dayForecastEntityList.length - 1) {
                      return Column(
                        children: [
                          HeaderCardSkeleton(
                            child: HeaderCardBody(
                              id: state.dayForecastEntityList[index].id,
                              name: state.dayForecastEntityList[index].name,
                              forecastBloc: forecastBloc,
                            ),
                          ),
                          DayForecastLineChartSkeleton(
                            child: DayForecastLineChartBody(
                              dayEntity: state.dayForecastEntityList[index],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          HeaderCardSkeleton(
                            child: HeaderCardBody(
                              id: state
                                  .weekForecastEntityList[index -
                                      state.dayForecastEntityList.length]
                                  .id,
                              name: state
                                  .weekForecastEntityList[index -
                                      state.dayForecastEntityList.length]
                                  .name,
                              forecastBloc: forecastBloc,
                            ),
                          ),
                          WeekForecastView(
                            children: List.generate(
                              state
                                  .weekForecastEntityList[index -
                                      state.dayForecastEntityList.length]
                                  .undetailedDayForecastEntityList
                                  .length,
                              (index2) => UndetailedDayForecastCardSkeleton(
                                child: UndetailedDayForecastCardBody(
                                  undetailedDayForecastEntity: state
                                      .weekForecastEntityList[index -
                                          state.dayForecastEntityList.length]
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
              throw StateError('UnexpectedState');
            },
          ),
        ),
      ),
    );
  }
}
