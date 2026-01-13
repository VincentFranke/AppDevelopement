import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/logic/blocs/current_input_bloc/current_input_bloc.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc_events.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc_states.dart';
import 'package:weather_app/logic/blocs/get_location_bloc/get_location_bloc.dart';
import 'package:weather_app/logic/blocs/get_location_bloc/get_location_bloc_events.dart';
import 'package:weather_app/logic/blocs/get_location_bloc/get_location_bloc_states.dart';
import 'package:weather_app/logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:weather_app/logic/blocs/settings_bloc/settings_bloc_events.dart';
import 'package:weather_app/logic/blocs/settings_bloc/settings_bloc_states.dart';
import 'package:weather_app/logic/blocs/view_type_bloc/view_type_bloc.dart';
import 'package:weather_app/logic/city_suggestion_card_layout_config.dart';
import 'package:weather_app/ui/add_city_page/add_city_page.dart';
import 'package:weather_app/ui/home_page_list.dart';
import 'package:weather_app/ui/home_page_list_loading.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final forecastBloc = context.read<ForecastBloc>();
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
              getLocationBloc.add(TryGetLocationEvent());
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
        child: RefreshIndicator(
          onRefresh: () {forecastBloc.add(HomePageRefreshEvent())},
          child: BlocBuilder<ForecastBloc, ForecastStates>(
            builder: (context, forecastState) {
              if (forecastState is DisplayForecastPreLoadingScreenState) {
                return Center(child: CupertinoActivityIndicator());
              } else if (forecastState is DisplayForecastLoadingErrorState) {
                return Center(child: Text(AppLocalizations.of(context)!.error));
              } else if (forecastState is DisplayForecastLoadingScreenState) {
                return HomePageListLoading(forecastState: forecastState);
              } else if (forecastState is DisplayForecastDataState) {
                return Builder(
                  builder: (context) {
                    // Durch den SettingsBloc gucken ob es sich um den ersten Durchlauf handelt demendsprechend Location verwendet durch GetLocationBloc
                    settingsBloc.add(SaveIsFirstRunEvent());
                    return BlocBuilder<SettingsBloc, SettingsBlocStates>(
                      builder: (context, settingsState) {
                        if (settingsState is IsFirstRunSavedState) {
                          if (settingsState.isFirstRun) {
                            getLocationBloc.add(TryGetLocationEvent());
                          } else {
                            getLocationBloc.add(ResetLocationBlocEvent());
                          }
                        }
                        // Anzeigen von Daten
                        return BlocBuilder<
                          GetLocationBloc,
                          GetLocationBlocStates
                        >(
                          builder: (context, getLocationState) {
                            if (getLocationState is GetLocationIdleState) {
                              return HomePageList(
                                forecastBloc: forecastBloc,
                                forecastState: forecastState,
                              );
                            } else if (getLocationState
                                is GetLocationLoadingState) {
                              return Column(
                                children: [
                                  Flexible(
                                    child: FractionallySizedBox(
                                      heightFactor: 0.4,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: CupertinoActivityIndicator(),
                                  ),
                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.locationLoadingMessage,
                                  ),
                                ],
                              );
                            } else if (getLocationState
                                is GetLocationErrorState) {
                              return ListView(
                                children: [Text(
                                  getLocationState.exception.toString(),
                                ),]
                              );
                            } else if (getLocationState
                                is GetLocationSuccessfullState) {
                              forecastBloc.add(
                                AddCityEvent(
                                  cityEntity: getLocationState.cityEntities[0],
                                  viewType:
                                      getLocationState.cityEntities[0].viewType!,
                                ),
                              );
                              forecastBloc.add(
                                AddCityEvent(
                                  cityEntity: getLocationState.cityEntities[1],
                                  viewType:
                                      getLocationState.cityEntities[1].viewType!,
                                ),
                              );
                              return Center(child: CupertinoActivityIndicator());
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
