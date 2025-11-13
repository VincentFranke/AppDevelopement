import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather_app/logic/entities/day_forecast_entity.dart';
import 'package:weather_app/logic/entities/seven_day_forecast_entity.dart';

Future<List<DayForecastEntity>> _fetchDayForecastList(
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

Future<List<SevenDayForecastEntity>> fetchSevenDayForecastList(
  List<String> names,
  List<double> lats,
  List<double> lons,
) async {
  List<SevenDayForecastEntity> result = [];

  for (int i = 0; i < names.length; i++) {
    List<DayForecastEntity> days = await _fetchDayForecastList(
      lats[i],
      lons[i],
    );
    result.add(
      SevenDayForecastEntity(header: names[i], dayForecastEntityList: days),
    );
  }
  return result;
}
