import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/presentation/blocs/view_type_bloc/view_type_events.dart';
import 'package:weather_app/features/weather/presentation/blocs/view_type_bloc/view_type_state.dart';
import 'package:weather_app/core/enums/view_type.dart';

class ViewTypeBloc extends Bloc<ViewTypeChanged, ViewTypeState> {
  ViewTypeBloc() : super(ViewTypeState(viewType: ViewType.dayView)) {
    on<ViewTypeChanged>((event, emit) {
      emit(ViewTypeState(viewType: event.newViewType));
    });
  }
}
