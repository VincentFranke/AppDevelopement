import 'package:weather_app/core/enums/view_type.dart';

class City {
  late final String? name;
  late final String? id;
  late final String? country;
  late final String? countryCode;
  late final String? federalState;
  late final double? lat;
  late final double? lon;
  late final ViewType? viewType;
  City({
    required this.name,
    required this.id,
    required this.country,
    required this.countryCode,
    required this.federalState,
    required this.lat,
    required this.lon,
    required this.viewType,
  });
}
