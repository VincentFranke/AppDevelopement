import 'package:flutter/material.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/logic/entities/day_forecast_entity.dart';
import 'package:weather_app/logic/mapper.dart';

class DayForecastCard extends StatelessWidget {
  final DayForecastEntity dayForecastEntity;
  const DayForecastCard({super.key, required this.dayForecastEntity});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              Mapper.getLocalizedLabel(
                label: dayForecastEntity.dayLabel,
                loc: AppLocalizations.of(context)!,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text('${dayForecastEntity.temperature} °C'),
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(
              Mapper.getIcon(weatherCode: dayForecastEntity.weatherCode),
              size: 50,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              Mapper.getLocalizedWeatherText(
                weatherCode: dayForecastEntity.weatherCode,
                loc: AppLocalizations.of(context)!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
