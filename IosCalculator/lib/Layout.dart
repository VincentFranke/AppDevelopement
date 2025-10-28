import 'package:flutter/material.dart';
import 'package:IosCalculator/Display.dart';
import 'package:IosCalculator/Grid.dart';
import 'package:IosCalculator/HistoryDisplay.dart';

class Layout extends StatelessWidget {

  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final externalPaddingSize = 0.05;
    final topPaddingSize = 0.29;
    final innerPaddingSize = 0.0;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * topPaddingSize,
          left: screenWidth * externalPaddingSize,
          right: screenWidth * externalPaddingSize,
          bottom: screenWidth * externalPaddingSize,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: screenHeight * innerPaddingSize,
                ),
                child: HistoryDisplay(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: screenHeight * innerPaddingSize,
                ),
                child: Display(),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.52,
              child: Grid(),
            ),
          ],
        ),
      ),
    );
  }
}
