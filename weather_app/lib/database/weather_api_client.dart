import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather_app/logic/entities/undetailed_day_forecast_entity.dart';
import 'package:weather_app/logic/entities/day_forecast_entity.dart';
import 'package:weather_app/logic/entities/hourly_forecast_entity.dart';
import 'package:weather_app/logic/entities/week_forecast_entity.dart';

Future<List<WeekForecastEntity>> fetchWeekForecastEntityList({
  required List<String> names,
  required List<String> ids,
  required List<double> lats,
  required List<double> lons,
}) async {
  List<WeekForecastEntity> result = [];

  for (int i = 0; i < names.length; i++) {
    List<UndetailedDayForecastEntity> days =
        await _fetchUndetailedDayForecastList(lats[i], lons[i]);
    result.add(
      WeekForecastEntity(
        id: ids[i],
        name: names[i],
        undetailedDayForecastEntityList: days,
      ),
    );
  }
  return result;
}

Future<List<UndetailedDayForecastEntity>> _fetchUndetailedDayForecastList(
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
      (index) => UndetailedDayForecastEntity.fromJson(
        jsonData: apiResponse,
        index: index,
      ),
    );
  }
  throw HttpException("HTTP-Request failed", uri: url);
}

Future<List<DayForecastEntity>> fetchDayForecastList({
  required List<String> ids,
  required List<String> names,
  required List<double> lats,
  required List<double> lons,
}) async {
  List<DayForecastEntity> result = [];

  for (int i = 0; i < names.length; i++) {
    result.add(
      await fetchDayForecastEntity(
        id: ids[i],
        name: names[i],
        lat: lats[i],
        lon: lons[i],
      ),
    );
  }
  return result;
}

Future<DayForecastEntity> fetchDayForecastEntity({
  required String id,
  required String name,
  required double lat,
  required double lon,
}) async {
  List<HourlyForecastEntity> hourlyForecastEntityList =
      await _fetchHourlyForecastList(name: name, lat: lat, lon: lon);

  final url = Uri.parse(
    'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&daily=sunrise,sunset&timezone=auto&forecast_days=1',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final apiResponse = json.decode(response.body) as Map<String, dynamic>;
    return DayForecastEntity.fromJson(
      id: id,
      name: name,
      hourlyForecastEntityList: hourlyForecastEntityList,
      jsonData: apiResponse,
    );
  }
  throw HttpException("HTTP-Request failed", uri: url);
}

Future<List<HourlyForecastEntity>> _fetchHourlyForecastList({
  required String name,
  required double lat,
  required double lon,
}) async {
  final url = Uri.parse(
    'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&hourly=temperature_2m,weather_code&timezone=auto&forecast_days=1',
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
