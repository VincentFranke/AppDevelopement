import 'package:flutter/widgets.dart';
import 'package:weather_app/ui/list_content/header_card.dart';
import 'package:weather_app/ui/list_content/seven_day_forecast_view.dart';

class TestData {
  static List<Widget> teporaryListList = [
    HeaderCard(header: 'Favorites', height: 50),
    HeaderCard(header: 'Oberursel', height: 30),
    SevenDayForecastView(),
    HeaderCard(header: 'Bad Homburg', height: 30),
    SevenDayForecastView(),
    HeaderCard(header: 'Schmitten', height: 30),
    SevenDayForecastView(),
  ];
}
