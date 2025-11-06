import 'package:bloc_exercise/logic/counter_bloc.dart';
import 'package:bloc_exercise/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: HomePage(title: 'Bloc Exercise'),
      ),
    );
  }
}
