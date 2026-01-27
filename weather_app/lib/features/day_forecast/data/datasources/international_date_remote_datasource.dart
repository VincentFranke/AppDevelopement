import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class InternationalDateTimeRemoteDatasource {
  static final _instance = InternationalDateTimeRemoteDatasource._internal();
  InternationalDateTimeRemoteDatasource._internal();

  factory InternationalDateTimeRemoteDatasource() {
    return _instance;
  }

  void initialize() {
    tz.initializeTimeZones();
  }

  tz.TZDateTime getInternationalDateTimeNow({required String timeZone}) {
    final cityLocation = tz.getLocation(timeZone);
    return tz.TZDateTime.now(cityLocation);
  }
}
