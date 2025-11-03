import 'package:IosCalculator/business_logic/add_and_remove_dots.dart';
import 'package:IosCalculator/business_logic/calculation_function.dart';
import 'package:IosCalculator/business_logic/validation_function.dart';
import 'package:IosCalculator/page_layout.dart';
import 'package:IosCalculator/state_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String currentCalculation = '0';
  String previousCalculation = '';
  ScrollController scrollController = ScrollController();

  void addData(String dataToAdd) {
    setState(() {
      currentCalculation = removeDots(currentCalculation);
      currentCalculation = validationFunction(dataToAdd, currentCalculation);
      previousCalculation = '';
      scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      );
      currentCalculation = addDots(currentCalculation);
    });
  }

  void deleteData() {
    setState(() {
      previousCalculation = '';
      scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      );
      currentCalculation = removeDots(currentCalculation);
      if (currentCalculation != '' && currentCalculation != '0') {
        currentCalculation = currentCalculation.substring(
          0,
          currentCalculation.length - 1,
        );
        if (currentCalculation.isEmpty) {
          currentCalculation = '0';
        }
      }
      currentCalculation = addDots(currentCalculation);
    });
  }

  void deleteAll() {
    setState(() {
      currentCalculation = '0';
      previousCalculation = '';
    });
  }

  void calculate() {
    final lastCharacter = currentCalculation[currentCalculation.length - 1];
    if (lastCharacter != '%' &&
        lastCharacter != '÷' &&
        lastCharacter != '×' &&
        lastCharacter != '-' &&
        lastCharacter != '+' &&
        currentCalculation != '0') {
      setState(() {
        scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        );
        previousCalculation = currentCalculation;
        currentCalculation = removeDots(currentCalculation);
        currentCalculation = currentCalculation.replaceAll(',', '.');
        final regex = RegExp(r'\d+(?:\.\d+)?|[-+×÷%]');
        final Iterable<RegExpMatch> matches = regex.allMatches(
          currentCalculation,
        );
        List<String> americanInputList = matches
            .map((m) => m.group(0)!)
            .toList();
        for (int i = 0; i <= americanInputList.length; i++) {
          // Minus Zahlen einbauen
          if (i == 0 && americanInputList[i] == '-') {
            // Falls erste Zahl Minus ist
            americanInputList.removeAt(0);
            americanInputList[0] = '-${americanInputList[0]}';
            continue;
          } else if (i == 0 && americanInputList[i] != '-') {
            // Falls erste Zahl kein Minus ist damit es nicht crasht
            continue;
          }

          if (i >= 2) {
            if (americanInputList[i - 1] == '-' &&
                num.tryParse(americanInputList[i]) != null &&
                num.tryParse(americanInputList[i - 2]) == null) {
              americanInputList.removeAt(i - 1);
              americanInputList[i - 1] = '-${americanInputList[i - 1]}';
            }
          }
        }
        currentCalculation = calculationFunction(americanInputList).toString();

        if (double.parse(currentCalculation) % 1 == 0) {
          currentCalculation = double.parse(
            currentCalculation,
          ).toInt().toString(); // Unnötiges .0 entfernen
        } else {
          currentCalculation = double.parse(
            currentCalculation,
          ).toStringAsFixed(8); // Nachkommastellen kürzen
          currentCalculation = double.parse(
            currentCalculation,
          ).toString(); // Unnötige Nullen entfernen wenn es keine Ganzzahl ist
        }
        currentCalculation = currentCalculation.replaceAll(
          '.',
          ',',
        ); // Punkt wieder zu Komma ändern für schöne Anzeige
        currentCalculation = addDots(currentCalculation);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StateProvider(state: this, child: PageLayout());
  }
}
