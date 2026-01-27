import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  late SharedPreferences _sharedPreferences;
  static final _instance = SharedPreferencesService._internal();

  SharedPreferencesService._internal();

  factory SharedPreferencesService() {
    return _instance;
  }

  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> isFirstRun() async {
    bool result = _sharedPreferences.getBool('isFirstRun') ?? true;

    if (result) {
      await _sharedPreferences.setBool('isFirstRun', false);
    }
    return result;
  }
}
