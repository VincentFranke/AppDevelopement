import 'package:hive_flutter/hive_flutter.dart';

class HiveCityDatabaseService {
  late Box _box;
  static final _instance = HiveCityDatabaseService._internal();
  HiveCityDatabaseService._internal();
  factory HiveCityDatabaseService() {
    return _instance;
  }

  Future<void> initialize() async {
    _box = await Hive.openBox("cities");
  }

  void addCity({
    required String name,
    required Map<String, dynamic> json,
  }) async {
    _box.put(name, json);
  }

  Map<String, dynamic> getCity({required String name}) {
    return _box.get(name);
  }

  List<Map<String, dynamic>> getAllCitys() {
    return _box.values.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  int getCityLength() {
    return _box.values.length;
  }

  void deleteCity({required String name}) {
    _box.delete(name);
  }

  void clear() {
    _box.clear();
  }
}
