import 'package:weather_app/logic/view_type.dart';

class CityEntity {
  late final String? name;
  late final String? id;
  late final String? country;
  late final String? countryCode;
  late final String? federalState;
  late final double? lat;
  late final double? lon;
  late final ViewType? viewType;
  CityEntity({
    required this.name,
    required this.id,
    required this.country,
    required this.countryCode,
    required this.federalState,
    required this.lat,
    required this.lon,
    required this.viewType,
  });
  CityEntity.fromRemoteJson({
    required Map<String, dynamic> jsonData,
    required int index,
    required this.viewType,
  }) {
    final shortenedJsonData =
        jsonData['results'][index] as Map<String, dynamic>;

    name = shortenedJsonData.containsKey('name')
        ? shortenedJsonData['name']
        : null;
    country = shortenedJsonData.containsKey('country')
        ? shortenedJsonData['country']
        : null;
    countryCode = shortenedJsonData.containsKey('country_code')
        ? shortenedJsonData['country_code']
        : null;
    federalState = shortenedJsonData.containsKey('admin1')
        ? shortenedJsonData['admin1']
        : null;
    lat = shortenedJsonData.containsKey('latitude')
        ? shortenedJsonData['latitude']
        : null;
    lon = shortenedJsonData.containsKey('longitude')
        ? shortenedJsonData['longitude']
        : null;
  }
  CityEntity.fromJson({
    required Map<String, dynamic> jsonData,
    required this.id,
  }) {
    name = jsonData.containsKey('name') ? jsonData['name'] : null;
    country = jsonData.containsKey('country') ? jsonData['country'] : null;
    countryCode = jsonData.containsKey('countryCode')
        ? jsonData['countryCode']
        : null;
    federalState = jsonData.containsKey('federalState')
        ? jsonData['federalState']
        : null;
    lat = jsonData.containsKey('lat') ? jsonData['lat'] : null;
    lon = jsonData.containsKey('lon') ? jsonData['lon'] : null;
    viewType = jsonData.containsKey('viewType')
        ? ViewType.values.firstWhere((e) => e.name == jsonData['viewType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country,
      'countryCode': countryCode,
      'federalState': federalState,
      'lat': lat,
      'lon': lon,
      'viewType': viewType?.name,
    };
  }
}
