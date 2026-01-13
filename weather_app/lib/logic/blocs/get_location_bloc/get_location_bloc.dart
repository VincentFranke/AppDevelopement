import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:weather_app/database/gps_api_client.dart';
import 'package:weather_app/database/location_api_client.dart';
import 'package:weather_app/logic/blocs/get_location_bloc/get_location_bloc_events.dart';
import 'package:weather_app/logic/blocs/get_location_bloc/get_location_bloc_states.dart';

class GetLocationBloc
    extends Bloc<GetLocationBlocEvents, GetLocationBlocStates> {
  GetLocationBloc() : super(GetLocationIdleState()) {
    on<TryGetLocationEvent>((event, emit) async {
      emit(GetLocationLoadingState());

      LocationData? locationData;
      try {
        locationData = await tryGetLocation();
      } on Exception catch (e) {
        emit(GetLocationErrorState(exception: e));
        return;
      }
      if (locationData == null) {
        emit(GetLocationIdleState());
        return;
      }
      final cityEntities = await fetchCityFromCoordinates(
        lat: locationData.latitude!,
        lon: locationData.longitude!,
      );
      emit(GetLocationSuccessfullState(cityEntities: cityEntities));
    });
    on<ResetLocationBlocEvent>((event, emit) {
      emit(GetLocationIdleState());
    });
  }
}
