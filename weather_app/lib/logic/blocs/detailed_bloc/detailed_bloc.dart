import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/database/hive_city_database_service.dart';
import 'package:weather_app/database/weather_api_client.dart';
import 'package:weather_app/logic/blocs/detailed_bloc/detailed_bloc_events.dart';
import 'package:weather_app/logic/blocs/detailed_bloc/detailed_bloc_states.dart';
import 'package:weather_app/logic/entities/city_entity.dart';

class DetailedBloc extends Bloc<DetailedBlocEvents, DetailedBlocStates> {
  DetailedBloc() : super(LoadingDetailedBlocState()) {
    on<RefreshDataDetailedBlocEvent>((event, emit) async {
      emit(LoadingDetailedBlocState());

      final cityToDisplay = CityEntity.fromJson(
        jsonData: HiveCityDatabaseService().getCity(name: event.header),
      );
      final detailedDayForecastEntity = await fetchDetailedDayForecastEntity(
        name: cityToDisplay.name!,
        lat: cityToDisplay.lat!,
        lon: cityToDisplay.lon!,
      );

      emit(
        ShowDataDetailedBlocState(
          detailedDayForecastEntity: detailedDayForecastEntity,
        ),
      );
    });
  }
}
