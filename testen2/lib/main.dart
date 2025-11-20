import 'package:testen2/pakete_zum_testen/weather_app/weather_api_client.dart';

void main() async {
  final result = await WeatherApiClient.fetchDetailedDayForecastEntityList(
    names: ['Oberursel'],
    lats: [50],
    lons: [50],
  );
  print(result);
}
