import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/domain/entities/city.dart';
import 'package:weather_app/core/enums/view_type.dart';
import 'package:weather_app/features/weather/data/datasources/hive_city_data_source.dart';

part 'add_city_event.dart';
part 'add_city_state.dart';

class AddCityBloc extends Bloc<AddCityEvent, AddCityState> {
  final HiveCityDataSourceImpl _hiveCityDatabaseService;

  AddCityBloc({required HiveCityDataSourceImpl hiveCityDatabaseService})
    : _hiveCityDatabaseService = hiveCityDatabaseService,
      super(AddCityInitial()) {
    on<AddCityAddCity>((event, emit) async {
      final viewAlreadyExists = await _hiveCityDatabaseService.addCity(
        name: event.cityEntity.name!,
        json: event.cityEntity.toInternalJson(),
      );
      emit(AddCityFinished(viewAlreadyExists));
      emit(AddCityInitial());
    });

    on<AddCityAddMultipleCitys>((event, emit) async {
      final viewAlreadyExistsDayView = await _hiveCityDatabaseService.addCity(
        name: event.citiesAndViewTypes.first.cityEntity.name!,
        json: event.citiesAndViewTypes.first.cityEntity.toInternalJson(),
      );
      final viewAlreadyExistsWeekView = await _hiveCityDatabaseService.addCity(
        name: event.citiesAndViewTypes.last.cityEntity.name!,
        json: event.citiesAndViewTypes.last.cityEntity.toInternalJson(),
      );

      emit(
        AddCityFinished(viewAlreadyExistsDayView && viewAlreadyExistsWeekView),
      );
      emit(AddCityInitial());
    });
  }
}
