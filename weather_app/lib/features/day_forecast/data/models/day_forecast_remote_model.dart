class DayForecastRemoteModel {
  // Ist ein Model welches einfach nur die DayForecast Datan ohne die hourly forecast Daten speichert.
  // Dies ist notwendig, da zwei Methoden aufgerufen werden müssen: Einmal die um die Tagesdaten zu holen und einmal für die stündlichen Daten
  // Beim holen der Tagesdaten kann wenn man das normale DayForecastModel verwendet das Attribut HourlyForecastList nicht bestückt werden da es nicht nullable ist
  // Um das Nullable machen zu vermeiden existiert diese Klasse, welche wirklich nur für den Zugriff da ist

  final String id;
  final String name;
  final DateTime sunrise;
  final DateTime sunset;
  final String timeZone;
  const DayForecastRemoteModel({
    required this.id,
    required this.name,
    required this.sunrise,
    required this.sunset,
    required this.timeZone,
  });
  DayForecastRemoteModel.fromJson({
    required this.id,
    required this.name,
    required Map<String, dynamic> jsonData,
  }) : sunrise = DateTime.parse(jsonData['daily']['sunrise'].first),
       sunset = DateTime.parse(jsonData['daily']['sunset'].first),
       timeZone = jsonData['timezone'];
}