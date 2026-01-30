import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/features/weather/data/models/city_model.dart';
import 'package:weather_app/core/error/exceptions.dart';

abstract interface class HiveCityDataSource {
  Future<void> initialize();

  Future<void> saveCity({
    required String id,
    required Map<String, dynamic> internalJson,
  });

  List<CityModel> getAllCities();

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
  Future<void> saveCity({
    required String id,
    required Map<String, dynamic> internalJson,
  }) async {
    id = '$id${internalJson['viewType']}';
    if (_box.containsKey(id)) {
      throw DataSourceException(message: 'City already exists');
    }
    _box.put(id, internalJson);
    return;
  }

  @override
  List<CityModel> getAllCities() {
    final List<CityModel> res = [];
    final iteratorKeys = _box.keys.iterator;
    final iteratorValues = _box.values.iterator;

    while (iteratorKeys.moveNext() && iteratorValues.moveNext()) {
      final json = Map<String, dynamic>.from(iteratorValues.current as Map);
      res.add(
        CityModel.fromInternalJson(jsonData: json, id: iteratorKeys.current),
      );
    }

    return res;
  }

  // @override
  // List<CityModel> gettAllCitysWeekView() {
  //   final List<CityModel> cities = [];
  //   final List<CityModel> res = [];
  //   final iteratorKeys = _box.keys.iterator;
  //   final iteratorValues = _box.values.iterator;

  //   while (iteratorKeys.moveNext() && iteratorValues.moveNext()) {
  //     final json = Map<String, dynamic>.from(iteratorValues.current as Map);
  //     cities.add(
  //       CityModel.fromInternalJson(jsonData: json, id: iteratorKeys.current),
  //     );
  //   }

  //   for (CityModel city in cities) {
  //     if (city.viewType == ViewType.weekView) {
  //       res.add(city);
  //     }
  //   }

  //   return res;
  // }

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
