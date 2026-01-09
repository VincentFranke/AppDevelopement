import 'package:flutter/material.dart';
import 'package:weather_app/database/hive_city_database_service.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc_events.dart';

class HeaderCardBody extends StatelessWidget {
  final String id;
  final String name;
  final ForecastBloc forecastBloc;
  const HeaderCardBody({
    super.key,
    required this.id,
    required this.name,
    required this.forecastBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: Theme.of(context).textTheme.titleMedium),
        IconButton(
          onPressed: () {
            HiveCityDatabaseService().deleteCity(id: id);
            forecastBloc.add(HomePageRefreshEvent());
          },
          icon: Icon(Icons.remove),
        ),
      ],
    );
  }
}
