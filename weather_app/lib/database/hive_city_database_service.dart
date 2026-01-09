import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/logic/entities/city_entity.dart';

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
    name = '$name${json['viewType']}';
    _box.put(name, json);
  }

  List<CityEntity> getAllCitys() {
    final List<CityEntity> result = [];
    final iteratorKeys = _box.keys.iterator;
    final iteratorValues = _box.values.iterator;

    while (iteratorKeys.moveNext() && iteratorValues.moveNext()) {
      final json = Map<String, dynamic>.from(iteratorValues.current as Map);
      result.add(CityEntity.fromJson(jsonData: json, id: iteratorKeys.current));
    }
    return result;
  }

  int getNumberOfCitiesDesignatedForDayView() {
    return _box.values.where((e) => e['viewType'] == 'dayView').length;
  }

  int getNumberOfCitiesDesignatedForWeekView() {
    return _box.values.where((e) => e['viewType'] == 'weekView').length;
  }

  void deleteCity({required String id}) {
    _box.delete(id);
  }

  void clear() {
    _box.clear();
  }

  // Das ist die Review Branch
}
