import 'dart:async';

import 'package:location/location.dart';
import 'package:weather_app/core/error/exceptions.dart';

abstract interface class GpsDataSource {
  Future<LocationData> tryFetchLocation();
}

class GpsDataSourceImpl implements GpsDataSource {
  @override
  Future<LocationData> tryFetchLocation() async {
    final location = Location();

    // Sicherstellen, dass Service an ist
    var serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();

      if (!serviceEnabled) {
        throw DataSourceException(
          message: 'Couldnt complete youre request. Gps-Service isnt enabled!',
        );
      }
    }

    // Sicherstellen, dass Berechtigungen vorhanden sind
    var currentPermission = await location.hasPermission();

    if (currentPermission == PermissionStatus.denied) {
      currentPermission = await location.requestPermission();

      if (currentPermission == PermissionStatus.denied ||
          currentPermission == PermissionStatus.deniedForever) {
        throw DataSourceException(
          message: 'Couldnt complete youre request. Gps-Access denied!',
        );
      }
    }

    // Location holen
    final timeoutDuration = Duration(seconds: 12);
    return await location.getLocation().timeout(
      timeoutDuration,
      onTimeout: () => throw DataSourceException(
        message: 'HTTP-Request Timeout ${timeoutDuration.toString()}',
      ),
    );
  }
}
