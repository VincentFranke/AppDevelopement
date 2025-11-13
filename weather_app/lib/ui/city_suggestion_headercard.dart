import 'package:flutter/material.dart';
import 'package:weather_app/logic/city_suggestion_card_layout_config.dart';

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
            child: Text('City'),
          ),
          Expanded(
            flex: citySuggestionCardLayoutConfig.federalStateFlexValue,
            child: Text('Federal State'),
          ),
          Expanded(
            flex: citySuggestionCardLayoutConfig.countryFlexValue,
            child: Text('Country'),
          ),
        ],
      ),
    );
  }
}
