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
    this.name,
    this.id,
    this.country,
    this.countryCode,
    this.federalState,
    this.lat,
    this.lon,
    this.viewType,
  });
}
