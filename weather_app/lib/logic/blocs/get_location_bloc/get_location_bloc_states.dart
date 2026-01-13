import 'package:weather_app/logic/entities/city_entity.dart';

abstract class GetLocationBlocStates {}

class GetLocationLoadingState extends GetLocationBlocStates {}

class GetLocationSuccessfullState extends GetLocationBlocStates {
  final List<CityEntity> cityEntities;
  GetLocationSuccessfullState({required this.cityEntities});
}

class GetLocationIdleState extends GetLocationBlocStates {}

class GetLocationErrorState extends GetLocationBlocStates {
  final Exception exception;
  GetLocationErrorState({required this.exception});
}
