import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/week_forecast/data/models/undetailed_day_forecast_model.dart';

abstract interface class WeekForecastDataSource {
  Future<List<UndetailedDayForecastModel>> fetchUndetailedDayForecastList({
    required double lat,
    required double lon,
  });
}

class WeekForecastDataSourceImpl implements WeekForecastDataSource {
  @override
  Future<List<UndetailedDayForecastModel>> fetchUndetailedDayForecastList({
    required double lat,
    required double lon,
  }) async {
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&daily=weather_code,temperature_2m_max&timezone=auto',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final apiResponse = json.decode(response.body) as Map<String, dynamic>;

      return List.generate(
        apiResponse['daily']['time'].length,
        (index) => UndetailedDayForecastModel.fromJson(
          jsonData: apiResponse,
          index: index,
        ),
      );
    }
    throw DataSourceException(message: "HTTP-Request failed ${url.toString()}");
  }
}
