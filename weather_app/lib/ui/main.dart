import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/database/hive_city_database_service.dart';
import 'package:weather_app/logic/blocs/current_input_bloc/current_input_bloc.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc.dart';
import 'package:weather_app/ui/home_page.dart';
import 'package:weather_app/ui/themes/dark_theme.dart';
import 'package:weather_app/ui/themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  HiveCityDatabaseService().initialize();
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = 'Weather App';
    return MaterialApp(
      title: title,
      theme: LightTheme.getTheme(),
      darkTheme: DarkTheme.getTheme(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ForecastBloc()),
          BlocProvider(create: (context) => CurrentInputBloc()),
        ],
        child: HomePage(title: title),
      ),
    );
  }
}
