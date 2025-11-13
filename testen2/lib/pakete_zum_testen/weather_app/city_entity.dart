class CityEntity {
  late final String? name;
  late final String? country;
  late final String? countryCode;
  late final String? federalState;
  late final double? lat;
  late final double? lon;
  CityEntity({
    required this.name,
    required this.country,
    required this.countryCode,
    required this.federalState,
    required this.lat,
    required this.lon,
  });
  CityEntity.fromJson({
    required Map<String, dynamic> jsonData,
    required int index,
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

  Map<String, dynamic> toJson(int index) {
    return {
      'results' : {index.toString(): {'name': name,
      'country': country,
      'countryCode': countryCode,
      'federalState': federalState,
      'lat': lat,
      'lon': lon}}
    };
  }
}