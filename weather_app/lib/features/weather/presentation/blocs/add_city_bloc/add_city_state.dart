part of 'add_city_bloc.dart';

@immutable
sealed class AddCityState {}

final class AddCityInitial extends AddCityState {}

final class AddCitySuccess extends AddCityState {}

class AddCityFailed extends AddCityState {
  final String message;

  AddCityFailed({required this.message});
}
