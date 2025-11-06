import 'package:bloc_exercise/logic/counter_bloc.dart';
import 'package:bloc_exercise/logic/counter_state.dart';
import 'package:bloc_exercise/logic/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final counterBloc = context.read<CounterBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text(
                  state.counter.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            ElevatedButton(
              onPressed: () => counterBloc.add(CounterIncrementPressed()),
              child: Center(child: Icon(Icons.plus_one)),
            ),
            ElevatedButton(
              onPressed: () => counterBloc.add(CounterDecrementPressed()),
              child: Center(child: Icon(Icons.exposure_minus_1)),
            ),
            ElevatedButton(
              onPressed: () => counterBloc.add(CounterDoublePressed()),
              child: Center(child: Icon(Icons.close)),
            ),
            ElevatedButton(
              onPressed: () => counterBloc.add(CounterHalfPressed()),
              child: Center(child: Text('÷')),
            ),
            ElevatedButton(
              onPressed: () => counterBloc.add(CounterResetPressed()),
              child: Center(child: Text('Reset')),
            ),
          ],
        ),
      ),
    );
  }
}
