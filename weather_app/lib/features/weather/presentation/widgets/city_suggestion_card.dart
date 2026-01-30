import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/week_forecast/presentation/blocs/week_forecast_bloc/week_forecast_bloc.dart';
import 'package:weather_app/features/week_forecast/presentation/blocs/week_forecast_bloc/week_forecast_event.dart';
import 'package:weather_app/features/weather/presentation/blocs/view_type_bloc/view_type_bloc.dart';
import 'package:weather_app/core/configs/city_suggestion_card_layout_config.dart';
import 'package:weather_app/features/weather/domain/entities/city.dart';

class CitySuggestionCard extends StatelessWidget {
  final City cityEntity;
  final CitySuggestionCardLayoutConfig citySuggestionCardLayoutConfig;
  final WeekForecastBloc forecastBloc;
  final ViewTypeBloc viewTypeBloc;
  const CitySuggestionCard({
    super.key,
    required this.cityEntity,
    required this.citySuggestionCardLayoutConfig,
    required this.forecastBloc,
    required this.viewTypeBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(citySuggestionCardLayoutConfig.padding),
      child: SizedBox(
        height: 30,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onPressed: () {
            forecastBloc.add(
              WeekForecastAddCity(
                cityEntity: cityEntity,
                viewType: viewTypeBloc.state.viewType,
              ),
            );
          },
          child: IgnorePointer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: citySuggestionCardLayoutConfig.countryCodeFlexValue,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CountryFlag.fromCountryCode(
                      cityEntity.countryCode ?? '',
                      theme: const ImageTheme(
                        shape: Circle(),
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: citySuggestionCardLayoutConfig.nameFlexValue,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(right: 8),
                      child: Text(cityEntity.name ?? ''),
                    ),
                  ),
                ),
                Expanded(
                  flex: citySuggestionCardLayoutConfig.federalStateFlexValue,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(right: 8),
                      child: Text(cityEntity.federalState ?? ''),
                    ),
                  ),
                ),
                Expanded(
                  flex: citySuggestionCardLayoutConfig.countryFlexValue,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(right: 8),
                      child: Text(cityEntity.country ?? ''),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
