import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/l10n/app_localizations.dart';
import 'package:weather_app/features/weather/presentation/blocs/current_input_bloc/current_input_bloc.dart';
import 'package:weather_app/features/week_forecast/presentation/blocs/week_forecast_bloc/week_forecast_bloc.dart';
import 'package:weather_app/features/week_forecast/presentation/blocs/week_forecast_bloc/week_forecast_events.dart';
import 'package:weather_app/features/week_forecast/presentation/blocs/week_forecast_bloc/week_forecast_states.dart';
import 'package:weather_app/features/weather/presentation/blocs/get_location_bloc/get_location_bloc.dart';
import 'package:weather_app/features/weather/presentation/blocs/get_location_bloc/get_location_events.dart';
import 'package:weather_app/features/weather/presentation/blocs/get_location_bloc/get_location_states.dart';
import 'package:weather_app/core/common/blocs/settings_bloc/settings_bloc.dart';
import 'package:weather_app/core/common/blocs/settings_bloc/settings_event.dart';
import 'package:weather_app/core/common/blocs/settings_bloc/settings_bloc_states.dart';
import 'package:weather_app/features/weather/presentation/blocs/view_type_bloc/view_type_bloc.dart';
import 'package:weather_app/core/configs/city_suggestion_card_layout_config.dart';
import 'package:weather_app/features/weather/presentation/pages/add_city_page.dart';
import 'package:weather_app/features/weather/presentation/widgets/home_page_list.dart';
import 'package:weather_app/features/weather/presentation/widgets/home_page_loading_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final forecastBloc = context.read<WeekForecastBloc>();
    final currentInputBloc = context.read<CurrentInputBloc>();
    final viewTypeBloc = context.read<ViewTypeBloc>();
    final getLocationBloc = context.read<GetLocationBloc>();
    final settingsBloc = context.read<SettingsBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
        actions: [
          IconButton(
            iconSize: 40,
            icon: Icon(CupertinoIcons.location_circle),
            onPressed: () {
              getLocationBloc.add(GetLocation());
            },
          ),
          IconButton(
            iconSize: 40,
            icon: Icon(CupertinoIcons.add),
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
          ),
        ],
      ),
      body: SizedBox.expand(
        // ForecastBloc
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            forecastBloc.add(WeekForecastRefresh());
          },
          child: BlocBuilder<WeekForecastBloc, WeekForecastStates>(
            builder: (context, forecastState) {
              bool snackbarTriggered = false;

              if (forecastState is WeekForecastPreLoading) {
                return Center(child: CircularProgressIndicator.adaptive());
              } else if (forecastState is WeekForecastError) {
                return Center(child: Text(AppLocalizations.of(context)!.error));
              } else if (forecastState is WeekForecastLoading) {
                return HomePageLoadingList(forecastState: forecastState);
              } else if (forecastState is WeekForecastSuccess) {
                return Builder(
                  builder: (context) {
                    if (forecastState.bothViewsAlreadyExist &&
                        !snackbarTriggered) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Center(
                              child: Text(
                                AppLocalizations.of(
                                  context,
                                )!.viewAlreadyExistsMessage,
                              ),
                            ),
                          ),
                        );
                      });
                      snackbarTriggered = true;
                    }
                    // Durch den SettingsBloc gucken ob es sich um den ersten Durchlauf handelt demendsprechend Location verwendet durch GetLocationBloc
                    settingsBloc.add(SettingsSaveIsFirstRun());
                    return BlocBuilder<SettingsBloc, SettingsState>(
                      builder: (context, settingsState) {
                        if (settingsState is IsFirstRunSaved) {
                          if (settingsState.isFirstRun) {
                            getLocationBloc.add(GetLocation());
                            //getLocationBloc.add(ResetLocationBlocEvent());
                          }
                          settingsBloc.add(
                            // Zum resetten des states
                            SettingsSaveIsFirstRun(),
                          );
                        }
                        // Anzeigen von Daten
                        return BlocBuilder<GetLocationBloc, GetLocationStates>(
                          builder: (context, getLocationState) {
                            if (getLocationState is GetLocationInitial) {
                              return HomePageList(
                                forecastBloc: forecastBloc,
                                forecastState: forecastState,
                              );
                            } else if (getLocationState
                                is GetLocationLoadingState) {
                              return Center(
                                child: Column(
                                  children: [
                                    Flexible(
                                      child: FractionallySizedBox(
                                        heightFactor: 0.45,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                      ),
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.locationLoadingMessage,
                                    ),
                                  ],
                                ),
                              );
                            } else if (getLocationState
                                is GetLocationPermissionDeniedState) {
                              WidgetsBinding.instance.addPostFrameCallback((
                                timeStamp,
                              ) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.gpsAccessDeniedMessage,
                                      ),
                                    ),
                                  ),
                                );
                              });
                              getLocationBloc.add(ResetLocationBlocEvent());
                              return HomePageList(
                                forecastBloc: forecastBloc,
                                forecastState: forecastState,
                              );
                            } else if (getLocationState is GetLocationFailed) {
                              getLocationBloc.add(ResetLocationBlocEvent());
                              WidgetsBinding.instance.addPostFrameCallback((
                                timeStamp,
                              ) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(
                                      child: Text(
                                        getLocationState.exception.toString(),
                                      ),
                                    ),
                                  ),
                                );
                              });
                              return Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            } else if (getLocationState is GetLocationSuccess) {
                              forecastBloc.add(
                                WeekForecastAddMultipleCitys(
                                  citysAndViewTypes: {
                                    getLocationState.cities[0]:
                                        getLocationState.cities[0].viewType!,
                                    getLocationState.cities[1]:
                                        getLocationState.cities[1].viewType!,
                                  },
                                ),
                              );
                              getLocationBloc.add(ResetLocationBlocEvent());
                              return Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            }
                            throw StateError('UnexpectedState');
                          },
                        );
                      },
                    );
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
