part of 'add_city_bloc.dart';

@immutable
sealed class AddCityState {}

final class AddCityInitial extends AddCityState {}

final class AddCityFinished extends AddCityState {
  final bool bothViewsAlreadyExist;

  AddCityFinished([this.bothViewsAlreadyExist = false]);
}
