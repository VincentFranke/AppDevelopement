import 'package:IosCalculator/displays_container.dart';
import 'package:IosCalculator/grid.dart';
import 'package:flutter/material.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[DisplaysContainer(), Grid()],
        ),
      ),
    );
  }
}
