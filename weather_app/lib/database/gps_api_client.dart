import 'dart:async';

import 'package:location/location.dart';

Future<LocationData?> tryGetLocation() async {
  final location = Location();

  // Sicherstellen, dass Service an ist
  var serviceEnabled = await location.serviceEnabled();

  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();

    if (!serviceEnabled) {
      return null;
    }
  }

  // Sicherstellen, dass Berechtigungen vorhanden sind
  var currentPermission = await location.hasPermission();

  if (currentPermission == PermissionStatus.denied) {
    currentPermission = await location.requestPermission();

    if (currentPermission == PermissionStatus.denied ||
        currentPermission == PermissionStatus.deniedForever) {
      return null;
    }
  }

  // Location holen
  final timeoutDuration = Duration(seconds: 10);
  return await location.getLocation().timeout(
    timeoutDuration,
    onTimeout: () =>
        throw TimeoutException('HTTP-Request Timeout', timeoutDuration),
  );
}
