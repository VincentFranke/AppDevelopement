import 'package:flutter/material.dart';
import 'package:weather_app/core/l10n/app_localizations.dart';
import 'package:weather_app/core/configs/city_suggestion_card_layout_config.dart';

class CitySuggestionHeadercard extends StatelessWidget {
  final CitySuggestionCardLayoutConfig citySuggestionCardLayoutConfig;
  const CitySuggestionHeadercard({
    super.key,
    required this.citySuggestionCardLayoutConfig,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(citySuggestionCardLayoutConfig.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: citySuggestionCardLayoutConfig.countryCodeFlexValue,
            child: Text(''),
          ),
          Expanded(
            flex: citySuggestionCardLayoutConfig.nameFlexValue,
            child: Text(AppLocalizations.of(context)!.city),
          ),
          Expanded(
            flex: citySuggestionCardLayoutConfig.federalStateFlexValue,
            child: Text(AppLocalizations.of(context)!.federalState),
          ),
          Expanded(
            flex: citySuggestionCardLayoutConfig.countryFlexValue,
            child: Text(AppLocalizations.of(context)!.country),
          ),
        ],
      ),
    );
  }
}
