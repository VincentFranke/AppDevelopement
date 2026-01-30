import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/common/blocs/app_bloc/app_bloc.dart';
import 'package:weather_app/features/weather/domain/usecases/safe_two_cities_from_gps.dart';
import 'package:weather_app/features/weather/presentation/blocs/get_location_bloc/get_location_events.dart';
import 'package:weather_app/features/weather/presentation/blocs/get_location_bloc/get_location_states.dart';

class GetLocationBloc extends Bloc<GetLocationEvents, GetLocationStates> {
  final SafeTwoCitiesFromGps _safeTwoCitiesFromGps;
  final AppBloc _appBloc;

  GetLocationBloc({
    required SafeTwoCitiesFromGps safeTwoCitiesFromGps,
    required AppBloc appBloc,
  }) : _safeTwoCitiesFromGps = safeTwoCitiesFromGps,
       _appBloc = appBloc,
       super(GetLocationInitial()) {
    on<GetLocation>((event, emit) async {
      emit(GetLocationLoadingState());

      final response = await _safeTwoCitiesFromGps();

      response.fold((l) => emit(GetLocationFailed(message: l.message)), (r) {
        emit(GetLocationSuccess());
        _appBloc.add(AppRefreshRequest());
      });

      emit(GetLocationInitial());
    });
  }
}
