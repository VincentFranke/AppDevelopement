import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/features/weather/data/datasources/hive_city_data_source.dart';
import 'package:weather_app/features/day_forecast/data/datasources/international_date_remote_datasource.dart';
import 'package:weather_app/core/utils/shared_preferences_service.dart';
import 'package:weather_app/core/l10n/app_localizations.dart';
import 'package:weather_app/features/weather/presentation/blocs/current_input_bloc/current_input_bloc.dart';
import 'package:weather_app/features/week_forecast/presentation/blocs/week_forecast_bloc/week_forecast_bloc.dart';
import 'package:weather_app/features/week_forecast/presentation/blocs/week_forecast_bloc/week_forecast_events.dart';
import 'package:weather_app/features/weather/presentation/blocs/get_location_bloc/get_location_bloc.dart';
import 'package:weather_app/core/common/blocs/settings_bloc/settings_bloc.dart';
import 'package:weather_app/features/weather/presentation/blocs/view_type_bloc/view_type_bloc.dart';
import 'package:weather_app/features/weather/presentation/pages/home_page.dart';
import 'package:weather_app/core/theme/dark_theme.dart';
import 'package:weather_app/core/theme/light_theme.dart';
import 'package:weather_app/init_dependencys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencys();
  await Hive.initFlutter();
  await HiveCityDataSourceImpl().initialize();
  await SharedPreferencesService().initialize();
  InternationalDateTimeRemoteDatasource().initialize();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              serviceLocator<WeekForecastBloc>()..add(WeekForecastRefresh()),
        ),
        BlocProvider(create: (context) => serviceLocator<CurrentInputBloc>()),
        BlocProvider(create: (context) => serviceLocator<ViewTypeBloc>()),
        BlocProvider(create: (context) => serviceLocator<GetLocationBloc>()),
        BlocProvider(create: (context) => serviceLocator<SettingsBloc>()),
      ],
      child: const WeatherApp(),
    ),
  );
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
      home: HomePage(),
    );
  }
}
