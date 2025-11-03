import 'package:IosCalculator/home_page.dart';
import 'package:flutter/material.dart';

class StateProvider extends InheritedWidget {
  final HomePageState state;

  const StateProvider({super.key, required this.state, required super.child});

  static StateProvider of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<StateProvider>();
    assert(result != null, 'No StateProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(StateProvider oldState) => oldState.state != state;
}
