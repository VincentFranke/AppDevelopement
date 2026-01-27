import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather_app/features/week_forecast/domain/entities/undetailed_day_forecast_entity.dart';
import 'package:weather_app/core/common/entities/week_forecast_entity.dart';

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
    'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&daily=weather_code,temperature_2m_max&timezone=auto',
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
