import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:testen2/pakete_zum_testen/weather_app/day_forecast_entity.dart';
import 'package:testen2/pakete_zum_testen/weather_app/detailed_day_forecast_entity.dart';
import 'package:testen2/pakete_zum_testen/weather_app/hourly_forecast_entity.dart';

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

  static Future<List<DetailedDayForecastEntity>>
  fetchDetailedDayForecastEntityList({
    required List<String> names,
    required List<double> lats,
    required List<double> lons,
  }) async {
    List<DetailedDayForecastEntity> result = [];

    for (int i = 0; i < names.length; i++) {
      List<HourlyForecastEntity> hourlyForecastEntityList =
          await _fetchHourlyForecastList(
            name: names[i],
            lat: lats[i],
            lon: lons[i],
          );
      result.add(
        DetailedDayForecastEntity(
          header: names[i],
          hourlyForecastEntityList: hourlyForecastEntityList,
        ),
      );
    }

    return result;
  }

  static Future<List<HourlyForecastEntity>> _fetchHourlyForecastList({
    required String name,
    required double lat,
    required double lon,
  }) async {
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m,weather_code&forecast_days=1',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final apiResponse = json.decode(response.body) as Map<String, dynamic>;

      return List.generate(
        apiResponse['hourly']['time'].length,
        (index) =>
            HourlyForecastEntity.fromJson(jsonData: apiResponse, index: index),
      );
    }
    throw HttpException("HTTP-Request failed", uri: url);
  }
}
