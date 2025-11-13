import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc.dart';
import 'package:weather_app/logic/city_suggestion_card_layout_config.dart';
import 'package:weather_app/logic/blocs/current_input_bloc/current_input_bloc.dart';
import 'package:weather_app/logic/blocs/current_input_bloc/current_input_bloc_events.dart';
import 'package:weather_app/logic/blocs/current_input_bloc/current_input_bloc_state.dart';
import 'package:weather_app/ui/city_suggestion_card.dart';
import 'package:weather_app/ui/city_suggestion_headercard.dart';

void showAddCityModalSheet({required BuildContext context}) {
  final currentInputBloc = context.read<CurrentInputBloc>();
  final forecastBloc = context.read<ForecastBloc>();
  final citySuggestionCardLayoutConfig = CitySuggestionCardLayoutConfig(
    padding: 5,
    countryCodeFlexValue: 1,
    countryFlexValue: 3,
    nameFlexValue: 2,
    federalStateFlexValue: 4,
  );

  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.red,
    context: context,
    builder: (context) {
      return BlocProvider<CurrentInputBloc>.value(
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
                TextField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(labelText: 'Select City'),
                  onChanged: (value) => currentInputBloc.add(
                    InputChangedEvent(currentInput: value),
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
                              ),
                            ],
                          );
                        }
                        return CitySuggestionCard(
                          cityEntity: state.citySuggestions[index],
                          citySuggestionCardLayoutConfig:
                              citySuggestionCardLayoutConfig,
                          forecastBloc: forecastBloc,
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
    },
  );
}
