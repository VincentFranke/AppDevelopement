import 'package:flutter/material.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/logic/entities/undetailed_day_forecast_entity.dart';
import 'package:weather_app/logic/mapper.dart';

class UndetailedDayForecastCardBody extends StatelessWidget {
  final UndetailedDayForecastEntity undetailedDayForecastEntity;
  const UndetailedDayForecastCardBody({
    super.key,
    required this.undetailedDayForecastEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            Mapper.getLocalizedLabel(
              label: undetailedDayForecastEntity.dayLabel,
              loc: AppLocalizations.of(context)!,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text('${undetailedDayForecastEntity.temperature} °C'),
        ),
        Align(
          alignment: Alignment.center,
          child: Icon(
            Mapper.getIcon(
              weatherCode: undetailedDayForecastEntity.weatherCode,
            ),
            size: 50,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            Mapper.getLocalizedWeatherText(
              weatherCode: undetailedDayForecastEntity.weatherCode,
              loc: AppLocalizations.of(context)!,
            ),
          ),
        ),
      ],
    );
  }
}
