import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc_events.dart';
import 'package:weather_app/logic/city_suggestion_card_layout_config.dart';
import 'package:weather_app/logic/entities/city_entity.dart';

class CitySuggestionCard extends StatelessWidget {
  final CityEntity cityEntity;
  final CitySuggestionCardLayoutConfig citySuggestionCardLayoutConfig;
  final ForecastBloc forecastBloc;
  const CitySuggestionCard({
    super.key,
    required this.cityEntity,
    required this.citySuggestionCardLayoutConfig,
    required this.forecastBloc,
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
            forecastBloc.add(AddCityEvent(cityEntity: cityEntity));
          },
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
                child: Text(cityEntity.name ?? ''),
              ),
              Expanded(
                flex: citySuggestionCardLayoutConfig.federalStateFlexValue,
                child: Text(cityEntity.federalState ?? ''),
              ),
              Expanded(
                flex: citySuggestionCardLayoutConfig.countryFlexValue,
                child: Text(cityEntity.country ?? ''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
