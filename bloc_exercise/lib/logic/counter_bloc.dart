import 'package:bloc_exercise/logic/counter_state.dart';
import 'package:bloc_exercise/logic/events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(counter: 0)) {
    on<CounterIncrementPressed>((event, emit) {
      emit(CounterState(counter: state.counter + 1));
    });
    on<CounterDecrementPressed>((event, emit) {
      emit(CounterState(counter: state.counter - 1));
    });
    on<CounterDoublePressed>((event, emit) {
      emit(CounterState(counter: state.counter * 2));
    });
    on<CounterHalfPressed>((event, emit) {
      if ((state.counter / 2) % 1 == 0) {
        emit(CounterState(counter: (state.counter / 2).toInt()));
      }
    });
    on<CounterResetPressed>((event, emit) {
      emit(CounterState(counter: 0));
    });
    // mayo
  }
}
