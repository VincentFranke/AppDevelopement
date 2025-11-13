import 'package:hive_flutter/hive_flutter.dart';

class HiveCityDatabaseService {
  late Box _box;
  static final _instance = HiveCityDatabaseService._internal();
  HiveCityDatabaseService._internal();
  factory HiveCityDatabaseService() {
    return _instance;
  }

  void initialize() async {
    _box = await Hive.openBox('cities');
  }

  void addCity({required String name, required Map<String, dynamic> json}) async {
    _box.put(name, json);
  }

  Map<String, dynamic> getCity({required String name}) {
    return _box.get(name);
  }

  List<Map<String, dynamic>> getAllCitys() {
    return _box.values.cast<Map<String, dynamic>>().toList();
  }

  void deleteCity({required String name}) {
    _box.delete(name);
  }

  void clear() {
    _box.clear();
  }
}
