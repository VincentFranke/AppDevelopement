import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/database/test_data.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc_states.dart';
import 'package:weather_app/ui/add_city_modal_sheet.dart';
import 'package:weather_app/ui/seven_day_forecast_view.dart';

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            iconSize: 50,
            onPressed: () => showAddCityModalSheet(context: context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<ForecastBloc, ForecastStates>(
        builder: (context, state) {
          if (state is DisplayForecastDataState) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.sevenDayForecastEntityList.length,
              itemBuilder: (context, index) {
                return SevenDayForecastView(
                  sevenDayForecastEntity:
                      state.sevenDayForecastEntityList[index],
                );
              },
            );
          } else if (state is DisplayForecastLoadingScreenState) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.citysToDisplayCount,
              itemBuilder: (context, index) {
                return SevenDayForecastView.shimmer();
              },
            );
          } else if (state is DisplayForecastPreLoadingScreenState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DisplayForecastLoadingErrorState) {
            return Center(child: Text('Error'));
          }
          return Center(child: Text('Error Invalid State'));
        },
      ),
    );
  }
}
