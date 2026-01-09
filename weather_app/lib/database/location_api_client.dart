import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather_app/logic/entities/city_entity.dart';
import 'package:weather_app/logic/view_type.dart';

Future<List<CityEntity>> fetchCitySuggestions({
  required String currentInput,
  required ViewType viewType,
}) async {
  final url = Uri.parse(
    'https://geocoding-api.open-meteo.com/v1/search?name=$currentInput&count=5&language=en&format=json',
  );
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final apiResponse = json.decode(response.body) as Map<String, dynamic>;

    if (apiResponse.length <= 1) {
      return [];
    }
    return List.generate(
      apiResponse['results'].length,
      (index) => CityEntity.fromRemoteJson(
        jsonData: apiResponse,
        index: index,
        viewType: viewType,
      ),
    );
  }
  throw HttpException("HTTP-Request failed", uri: url);
}
