import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/logic/blocs/view_type_bloc/view_type_bloc_events.dart';
import 'package:weather_app/logic/blocs/view_type_bloc/view_type_bloc_state.dart';
import 'package:weather_app/logic/view_type.dart';

class ViewTypeBloc extends Bloc<ViewTypeBlocEvents, ViewTypeBlocState> {
  ViewTypeBloc() : super(ViewTypeBlocState(viewType: ViewType.dayView)) {
    on<ViewTypeChangedEvent>((event, emit) {
      emit(ViewTypeBlocState(viewType: event.newViewType));
    });
  }
}
