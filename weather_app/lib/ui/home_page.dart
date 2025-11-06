import 'package:flutter/material.dart';
import 'package:weather_app/logic/test_data.dart';

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: (ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: TestData.teporaryListList.length,
        itemBuilder: (context, index) {
          return TestData.teporaryListList[index];
        },
      )),
    );
  }
}
