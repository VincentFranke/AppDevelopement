abstract class GetLocationStates {}

class GetLocationInitial extends GetLocationStates {}

class GetLocationLoadingState extends GetLocationStates {}

class GetLocationSuccess extends GetLocationStates {}

class GetLocationFailed extends GetLocationStates {
  final String message;
  GetLocationFailed({required this.message});
}
