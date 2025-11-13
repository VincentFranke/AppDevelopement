import 'package:testen2/pakete_zum_testen/weather_app/location_api_client.dart';

void main() async {
  final result = await fetchCitySuggestions('Lond');
  print(result);
}
