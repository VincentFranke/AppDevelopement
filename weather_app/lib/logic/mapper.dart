import 'package:flutter/material.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/logic/day_label.dart';
import 'package:weather_icons/weather_icons.dart';

class Mapper {
  static String getLocalizedLabel({
    required DayLabel label,
    required AppLocalizations loc,
  }) {
    switch (label) {
      case DayLabel.monday:
        return loc.monday;
      case DayLabel.tuesday:
        return loc.tuesday;
      case DayLabel.wednesday:
        return loc.wednesday;
      case DayLabel.thursday:
        return loc.thursday;
      case DayLabel.friday:
        return loc.friday;
      case DayLabel.saturday:
        return loc.saturday;
      case DayLabel.sunday:
        return loc.sunday;
    }
  }

  static String getLocalizedWeatherText({
    required int weatherCode,
    required AppLocalizations loc,
  }) {
    switch (weatherCode) {
      case 0:
        return loc.code0;
      case 1:
        return loc.code1;
      case 2:
        return loc.code2;
      case 3:
        return loc.code3;
      case 45:
        return loc.code45;
      case 48:
        return loc.code48;
      case 51:
        return loc.code51;
      case 53:
        return loc.code53;
      case 55:
        return loc.code55;
      case 56:
        return loc.code56;
      case 57:
        return loc.code57;
      case 61:
        return loc.code61;
      case 63:
        return loc.code63;
      case 65:
        return loc.code65;
      case 66:
        return loc.code66;
      case 67:
        return loc.code67;
      case 71:
        return loc.code71;
      case 73:
        return loc.code73;
      case 75:
        return loc.code75;
      case 77:
        return loc.code77;
      case 80:
        return loc.code80;
      case 81:
        return loc.code81;
      case 82:
        return loc.code82;
      case 85:
        return loc.code85;
      case 86:
        return loc.code86;
      case 95:
        return loc.code95;
      case 96:
        return loc.code96;
      case 99:
        return loc.code99;
      case _:
        return loc.codeUnknown;
    }
  }

  static IconData getIcon({required int weatherCode}) {
    switch (weatherCode) {
      case 0:
        return WeatherIcons.day_sunny;
      case 1:
        return WeatherIcons.day_sunny_overcast;
      case 2:
        return WeatherIcons.day_cloudy;
      case 3:
        return WeatherIcons.cloudy;
      case 45:
      case 48:
        return WeatherIcons.fog;
      case 51:
      case 53:
        return WeatherIcons.sprinkle;
      case 55:
        return WeatherIcons.rain_mix;
      case 56:
      case 57:
        return WeatherIcons.sleet;
      case 61:
      case 63:
        return WeatherIcons.rain;
      case 65:
        return WeatherIcons.rain_wind;
      case 66:
      case 67:
        return WeatherIcons.sleet;
      case 71:
      case 73:
        return WeatherIcons.snow;
      case 75:
        return WeatherIcons.snow_wind;
      case 77:
        return WeatherIcons.snow;
      case 80:
      case 81:
        return WeatherIcons.showers;
      case 82:
        return WeatherIcons.rain_wind;
      case 85:
        return WeatherIcons.snow;
      case 86:
        return WeatherIcons.snow_wind;
      case 95:
      case 96:
      case 99:
        return WeatherIcons.thunderstorm;
      case _:
        return Icons.question_mark;
    }
  }
}
