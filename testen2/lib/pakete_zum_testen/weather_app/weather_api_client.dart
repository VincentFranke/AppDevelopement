import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:testen2/pakete_zum_testen/weather_app/day_forecast_entity.dart';

class WeatherApiClient {
  static Future<List<DayForecastEntity>> fetchSevenDayForecastData(
    double lat,
    double lon,
  ) async {
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&daily=weather_code,temperature_2m_max&timezone=Europe%2FBerlin',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final apiResponse = json.decode(response.body) as Map<String, dynamic>;

      return List.generate(
        apiResponse['daily']['time'].length,
        (index) =>
            DayForecastEntity.fromJson(jsonData: apiResponse, index: index),
      );
    }
    throw HttpException("HTTP-Request failed", uri: url);
  }
}
