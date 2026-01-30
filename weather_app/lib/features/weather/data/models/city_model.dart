import 'package:weather_app/core/enums/view_type.dart';
import 'package:weather_app/features/weather/domain/entities/city.dart';

class CityModel extends City {
  CityModel({
    required super.name,
    required super.id,
    required super.country,
    required super.countryCode,
    required super.federalState,
    required super.lat,
    required super.lon,
    required super.viewType,
  });

  CityModel.fromRemoteJson({
    required Map<String, dynamic> jsonData,
    required int index,
    required super.viewType,
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
  CityModel.fromInternalJson({
    required Map<String, dynamic> jsonData,
    required super.id,
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

  Map<String, dynamic> toInternalJson() {
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

  CityModel copyWith({
    String? id,
    String? name,
    String? country,
    String? countryCode,
    String? federalState,
    double? lat,
    double? lon,
    ViewType? viewType,
  }) {
    return CityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
      federalState: federalState ?? this.federalState,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      viewType: viewType ?? this.viewType,
    );
  }
}
