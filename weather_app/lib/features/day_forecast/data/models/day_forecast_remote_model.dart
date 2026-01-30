import 'package:weather_app/features/day_forecast/domain/entities/day_forecast_remote.dart';

class DayForecastRemoteModel extends DayForecastRemote {
  // Ist ein Model welches einfach nur die DayForecast Datan ohne die hourly forecast Daten speichert.
  // Dies ist notwendig, da zwei Methoden aufgerufen werden müssen: Einmal die um die Tagesdaten zu holen und einmal für die stündlichen Daten
  // Beim holen der Tagesdaten kann wenn man das normale DayForecastModel verwendet das Attribut HourlyForecastList nicht bestückt werden da es nicht nullable ist
  // Um das Nullable machen zu vermeiden existiert diese Klasse, welche wirklich nur für den Zugriff da ist

  const DayForecastRemoteModel({
    required super.sunrise,
    required super.sunset,
    required super.timeZone,
  });
  factory DayForecastRemoteModel.fromJson({
    required Map<String, dynamic> jsonData,
  }) {
    return DayForecastRemoteModel(
      sunrise: DateTime.parse(jsonData['daily']['sunrise'].first),
      sunset: DateTime.parse(jsonData['daily']['sunset'].first),
      timeZone: jsonData['timezone'],
    );
  }
}
