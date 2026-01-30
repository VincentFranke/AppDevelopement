import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather_app/features/weather/data/models/city_model.dart';
import 'package:weather_app/core/enums/view_type.dart';

abstract interface class LocationDataSource {
  Future<List<CityModel>> fetchFiveCitySuggestions({
    required String currentInput,
    required ViewType viewType,
  });

  Future<CityModel> fetchCityFromCoordinates({
    required double lat,
    required double lon,
  });
}

class LocationDataSourceImpl implements LocationDataSource {
  @override
  Future<List<CityModel>> fetchFiveCitySuggestions({
    required String currentInput,
    required ViewType viewType,
  }) async {
    // Achtung ViewType wird auf null gesetzt
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
        (index) => CityModel.fromRemoteJson(
          jsonData: apiResponse,
          index: index,
          viewType: viewType,
        ),
      );
    }
    throw HttpException("HTTP-Request failed", uri: url);
  }

  @override
  Future<CityModel> fetchCityFromCoordinates({
    required double lat,
    required double lon,
  }) async {
    final url = Uri.parse(
      'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=$lat&longitude=$lon&localityLanguage=en',
    );
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw HttpException('HTTP-Request failed', uri: url);
    }

    final apiResponse = json.decode(response.body) as Map<String, dynamic>;

    final url2 = Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search?name=${apiResponse['city']}&count=1&language=en&format=json',
    );
    final response2 = await http.get(url2);

    if (response2.statusCode != 200) {
      throw HttpException('HTTP-Request failed', uri: url2);
    }

    final apiResponse2 = json.decode(response2.body) as Map<String, dynamic>;

    return CityModel.fromRemoteJson(
      jsonData: apiResponse2,
      index: 0,
      viewType: null,
    );
  }
}
