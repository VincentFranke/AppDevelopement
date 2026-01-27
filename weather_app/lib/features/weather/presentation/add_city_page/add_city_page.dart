import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/l10n/app_localizations.dart';
import 'package:weather_app/features/weather/presentation/blocs/current_input_bloc/current_input_bloc.dart';
import 'package:weather_app/features/weather/presentation/blocs/current_input_bloc/current_input_bloc_events.dart';
import 'package:weather_app/features/weather/presentation/blocs/current_input_bloc/current_input_bloc_state.dart';
import 'package:weather_app/features/week_forecast/presentation/blocs/week_forecast_bloc/week_forecast_bloc.dart';
import 'package:weather_app/features/weather/presentation/blocs/view_type_bloc/view_type_bloc.dart';
import 'package:weather_app/core/configs/city_suggestion_card_layout_config.dart';
import 'package:weather_app/features/weather/presentation/add_city_page/city_suggestion_card.dart';
import 'package:weather_app/features/weather/presentation/add_city_page/city_suggestion_headercard.dart';
import 'package:weather_app/features/weather/presentation/add_city_page/view_type_segmented_button.dart';

class AddCityPage extends StatelessWidget {
  final CurrentInputBloc currentInputBloc;
  final CitySuggestionCardLayoutConfig citySuggestionCardLayoutConfig;
  final WeekForecastBloc forecastBloc;
  final ViewTypeBloc viewTypeBloc;

  const AddCityPage({
    super.key,
    required this.citySuggestionCardLayoutConfig,
    required this.currentInputBloc,
    required this.forecastBloc,
    required this.viewTypeBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: currentInputBloc,
      child: Padding(
        padding: EdgeInsetsGeometry.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ViewTypeSegmentedButton(
                viewTypeBloc: viewTypeBloc,
                currentInputBloc: currentInputBloc,
              ),
              TextField(
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.selectCity,
                ),
                onChanged: (value) => currentInputBloc.add(
                  CurrentInputChangedEvent(
                    currentInput: value,
                    viewType: viewTypeBloc.state.viewType,
                  ),
                ),
              ),
              BlocBuilder<CurrentInputBloc, CurrentInputBlocState>(
                builder: (context, state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.citySuggestions.length.clamp(0, 5),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CitySuggestionHeadercard(
                              citySuggestionCardLayoutConfig:
                                  citySuggestionCardLayoutConfig,
                            ),
                            CitySuggestionCard(
                              cityEntity: state.citySuggestions[index],
                              citySuggestionCardLayoutConfig:
                                  citySuggestionCardLayoutConfig,
                              forecastBloc: forecastBloc,
                              viewTypeBloc: viewTypeBloc,
                            ),
                          ],
                        );
                      }
                      return CitySuggestionCard(
                        cityEntity: state.citySuggestions[index],
                        citySuggestionCardLayoutConfig:
                            citySuggestionCardLayoutConfig,
                        forecastBloc: forecastBloc,
                        viewTypeBloc: viewTypeBloc,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
