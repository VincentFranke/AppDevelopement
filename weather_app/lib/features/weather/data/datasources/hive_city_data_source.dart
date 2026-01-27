import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/features/weather/domain/entities/city.dart';
import 'package:weather_app/core/enums/view_type.dart';
import 'package:weather_app/core/error/exceptions.dart';

abstract interface class HiveCityDataSource {
  Future<void> initialize();

  Future<void> addCity({
    required String name,
    required Map<String, dynamic> internalJson,
  });

  List<City> getAllCitysDayView();

  List<City> gettAllCitysWeekView();

  int getCitiesForDayViewLength();

  int getCitiesForWeekViewLength();

  void deleteCity({required String id});

  void clear();
}

class HiveCityDataSourceImpl implements HiveCityDataSource {
  late Box _box;

  @override
  Future<void> initialize() async {
    _box = await Hive.openBox("cities");
  }

  @override
  Future<void> addCity({
    required String name,
    required Map<String, dynamic> internalJson,
  }) async {
    name = '$name${internalJson['viewType']}';
    if (_box.containsKey(name)) {
      throw DataSourceException(message: 'City already exists');
    }
    _box.put(name, internalJson);
    return;
  }

  @override
  List<City> getAllCitysDayView() {
    final List<City> cities = [];
    final List<City> res = [];
    final iteratorKeys = _box.keys.iterator;
    final iteratorValues = _box.values.iterator;

    while (iteratorKeys.moveNext() && iteratorValues.moveNext()) {
      final json = Map<String, dynamic>.from(iteratorValues.current as Map);
      cities.add(
        City.fromInternalJson(jsonData: json, id: iteratorKeys.current),
      );
    }

    for (City city in cities) {
      if (city.viewType == ViewType.dayView) {
        res.add(city);
      }
    }

    return res;
  }

  @override
  List<City> gettAllCitysWeekView() {
    final List<City> cities = [];
    final List<City> res = [];
    final iteratorKeys = _box.keys.iterator;
    final iteratorValues = _box.values.iterator;

    while (iteratorKeys.moveNext() && iteratorValues.moveNext()) {
      final json = Map<String, dynamic>.from(iteratorValues.current as Map);
      cities.add(
        City.fromInternalJson(jsonData: json, id: iteratorKeys.current),
      );
    }

    for (City city in cities) {
      if (city.viewType == ViewType.weekView) {
        res.add(city);
      }
    }

    return res;
  }

  @override
  int getCitiesForDayViewLength() {
    return _box.values.where((e) => e['viewType'] == 'dayView').length;
  }

  @override
  int getCitiesForWeekViewLength() {
    return _box.values.where((e) => e['viewType'] == 'weekView').length;
  }

  @override
  void deleteCity({required String id}) {
    _box.delete(id);
  }

  @override
  void clear() {
    // Nur für debugging bislang
    _box.clear();
  }
}
