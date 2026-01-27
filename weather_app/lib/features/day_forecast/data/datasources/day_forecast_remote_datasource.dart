import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather_app/features/day_forecast/data/models/day_forecast_remote_model.dart';
import 'package:weather_app/features/day_forecast/data/models/hourly_forecast_model.dart';

abstract interface class DayForecastRemoteDatasource {
  Future<DayForecastRemoteModel> fetchDayForecastOnlyDayData({
  required String id,
  required String name,
  required double lat,
  required double lon,
});

Future<List<HourlyForecastModel>> fetchHourlyForecastList({
  required String name,
  required double lat,
  required double lon,
});
}

class DayForecastRemoteDatasourceImpl implements DayForecastRemoteDatasource{

@override
Future<DayForecastRemoteModel> fetchDayForecastOnlyDayData({
  required String id,
  required String name,
  required double lat,
  required double lon,
}) async {
  final url = Uri.parse(
    'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&daily=sunrise,sunset&timezone=auto&forecast_days=1',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final apiResponse = json.decode(response.body) as Map<String, dynamic>;
    return DayForecastRemoteModel.fromJson(
      id: id,
      name: name,
      jsonData: apiResponse,
    );
  }
  throw HttpException("HTTP-Request failed", uri: url);
}

@override
Future<List<HourlyForecastModel>> fetchHourlyForecastList({
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
      (index) => HourlyForecastModel.fromJson(jsonData: apiResponse, index: index),
    );
  }
  throw HttpException("HTTP-Request failed", uri: url);
}
}
