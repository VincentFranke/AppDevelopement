class HourlyForecastEntity {
  late final DateTime time;
  final double temperature;
  final int weatherCode;
  HourlyForecastEntity({
    required this.time,
    required this.temperature,
    required this.weatherCode,
  });

  HourlyForecastEntity.fromJson({
    required Map<String, dynamic> jsonData,
    required int index,
  }) : temperature = jsonData['hourly']['temperature_2m'][index],
       weatherCode = jsonData['hourly']['weather_code'][index],
       time = DateTime.parse(jsonData['hourly']['time'][index]);
}
