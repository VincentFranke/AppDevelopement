import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/common/blocs/app_bloc/app_bloc.dart';
import 'package:weather_app/features/weather/domain/entities/city.dart';
import 'package:weather_app/features/weather/domain/usecases/save_city.dart';

part 'add_city_event.dart';
part 'add_city_state.dart';

class AddCityBloc extends Bloc<AddCityEvent, AddCityState> {
  final SaveCity _saveCity;
  final AppBloc _appBloc;

  AddCityBloc({required SaveCity saveCity, required AppBloc appBloc})
    : _saveCity = saveCity,
      _appBloc = appBloc,
      super(AddCityInitial()) {
    on<AddCityAddCity>((event, emit) async {
      // Gehe hier davon aus, dass ViewType in der Entität gesetzt ist deshalb wird es nicht explizit im Event verlangt
      final response = await _saveCity(city: event.city);

      response.fold(
        (l) => emit(AddCityFailed(message: l.message)),
        (r) => emit(AddCitySuccess()),
      );

      emit(AddCityInitial());
    });

    on<AddCityAddCities>((event, emit) async {
      bool stop = false;
      for (City c in event.cities) {
        (await _saveCity(city: c)).fold((l) {
          emit(AddCityFailed(message: l.message));
          stop = true;
        }, (_) {});

        if (stop) {
          break;
        }
      }

      if (!stop) {
        emit(AddCitySuccess());
      }

      _appBloc.add(AppRefreshRequest());

      emit(AddCityInitial());
    });
  }
}
