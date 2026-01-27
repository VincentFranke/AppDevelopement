import 'package:weather_app/features/weather/domain/entities/city.dart';

abstract class GetLocationBlocStates {}

class GetLocationLoadingState extends GetLocationBlocStates {}

class GetLocationSuccessfullState extends GetLocationBlocStates {
  final List<City> cityEntities;
  GetLocationSuccessfullState({required this.cityEntities});
}

class GetLocationIdleState extends GetLocationBlocStates {}

class GetLocationPermissionDeniedState extends GetLocationBlocStates {}

class GetLocationErrorState extends GetLocationBlocStates {
  final Exception exception;
  GetLocationErrorState({required this.exception});
}
