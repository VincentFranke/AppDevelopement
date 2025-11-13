import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:testen2/pakete_zum_testen/weather_app/city_entity.dart';

Future<List<CityEntity>> fetchCitySuggestions(String currentInput) async {
  final url = Uri.parse(
    'https://geocoding-api.open-meteo.com/v1/search?name=$currentInput&count=5&language=en&format=json',
  );
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final apiResponse = json.decode(response.body) as Map<String, dynamic>;

    return List.generate(
      apiResponse['results'].length,
      (index) => CityEntity.fromJson(jsonData: apiResponse, index: index),
    );
  }
  throw HttpException("HTTP-Request failed", uri: url);
}
