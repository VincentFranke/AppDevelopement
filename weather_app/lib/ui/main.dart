import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/database/hive_city_database_service.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/logic/blocs/current_input_bloc/current_input_bloc.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc_events.dart';
import 'package:weather_app/logic/blocs/view_type_bloc/view_type_bloc.dart';
import 'package:weather_app/ui/home_page.dart';
import 'package:weather_app/ui/themes/dark_theme.dart';
import 'package:weather_app/ui/themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveCityDatabaseService().initialize();
  //HiveCityDatabaseService().clear();
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LightTheme.getTheme(),
      darkTheme: DarkTheme.getTheme(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('de')],
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ForecastBloc()..add(HomePageRefreshEvent()),
          ),
          BlocProvider(create: (context) => CurrentInputBloc()),
          BlocProvider(create: (context) => ViewTypeBloc()),
        ],
        child: HomePage(),
      ),
    );
  }
}
