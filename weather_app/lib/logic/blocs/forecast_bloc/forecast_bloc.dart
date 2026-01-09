import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/database/hive_city_database_service.dart';
import 'package:weather_app/database/weather_api_client.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc_events.dart';
import 'package:weather_app/logic/blocs/forecast_bloc/forecast_bloc_states.dart';
import 'package:weather_app/logic/entities/city_entity.dart';
import 'package:weather_app/logic/entities/day_forecast_entity.dart';
import 'package:weather_app/logic/entities/week_forecast_entity.dart';
import 'package:weather_app/logic/view_type.dart';

class ForecastBloc extends Bloc<ForecastBlocEvent, ForecastStates> {
  final HiveCityDatabaseService hiveCityDatabaseService;
  ForecastBloc()
    : hiveCityDatabaseService = HiveCityDatabaseService(),
      super(DisplayForecastPreLoadingScreenState()) {
    on<HomePageRefreshEvent>((event, emit) async {
      emit(
        DisplayForecastLoadingScreenState(
          numberOfCitiesDesignatedForWeekView: hiveCityDatabaseService
              .getNumberOfCitiesDesignatedForWeekView(),
          numberOfCitiesDesignatedForDayView: hiveCityDatabaseService
              .getNumberOfCitiesDesignatedForDayView(),
        ),
      );
      emit(
        DisplayForecastDataState(
          weekForecastEntityList: await _getCurrentWeekForecastData(),
          dayForecastEntityList: await _getCurrentDayForecastData(),
        ),
      );
    });
    on<AddCityEvent>((event, emit) async {
      emit(
        DisplayForecastLoadingScreenState(
          numberOfCitiesDesignatedForWeekView: hiveCityDatabaseService
              .getNumberOfCitiesDesignatedForWeekView(),
          numberOfCitiesDesignatedForDayView: hiveCityDatabaseService
              .getNumberOfCitiesDesignatedForDayView(),
        ),
      );
      //event.cityEntity.viewType = event.viewType; // Muss aktualisiert werden, da in einem Spezialfall (Plus-Zeichen wird gedrückt ohne dass etwas eingegeben wird) die alten Entities recycelt werden und jene noch den alten ViewType haben
      // Ggf. woanders hinschreiben oder den State vom ViewType durch einen Bloc speichern o.Ä.
      hiveCityDatabaseService.addCity(
        name: event.cityEntity.name!,
        json: event.cityEntity.toJson(),
      );
      emit(
        DisplayForecastDataState(
          weekForecastEntityList: await _getCurrentWeekForecastData(),
          dayForecastEntityList: await _getCurrentDayForecastData(),
        ),
      );
    });
  }

  Future<List<WeekForecastEntity>> _getCurrentWeekForecastData() async {
    final List<CityEntity> citys = hiveCityDatabaseService.getAllCitys();
    final List<CityEntity> citiesDesignatedForWeekView = [];

    for (CityEntity city in citys) {
      if (city.viewType == ViewType.weekView) {
        citiesDesignatedForWeekView.add(city);
      }
    }

    return fetchWeekForecastEntityList(
      names: citiesDesignatedForWeekView.map((c) => c.name!).toList(),
      ids: citiesDesignatedForWeekView.map((c) => c.id!).toList(),
      lats: citiesDesignatedForWeekView.map((c) => c.lat!).toList(),
      lons: citiesDesignatedForWeekView.map((c) => c.lon!).toList(),
    );
  }

  Future<List<DayForecastEntity>> _getCurrentDayForecastData() async {
    final List<CityEntity> citys = hiveCityDatabaseService.getAllCitys();
    final List<CityEntity> citiesDesignatedForDayView = [];

    for (CityEntity city in citys) {
      if (city.viewType == ViewType.dayView) {
        citiesDesignatedForDayView.add(city);
      }
    }

    return fetchDayForecastList(
      ids: citiesDesignatedForDayView.map((c) => c.id!).toList(),
      names: citiesDesignatedForDayView.map((c) => c.name!).toList(),
      lats: citiesDesignatedForDayView.map((c) => c.lat!).toList(),
      lons: citiesDesignatedForDayView.map((c) => c.lon!).toList(),
    );
  }
}
