import 'package:IosCalculator/CalculationFunction.dart';
import 'package:IosCalculator/StateProvider.dart';
import 'package:flutter/material.dart';
import 'package:IosCalculator/Layout.dart';
import 'package:math_parser/math_parser.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => DataState();
}

class DataState extends State<Data> {
  String currentCalculation = '';
  String previousCalculation = '';

  void addData(String dataToAdd) {
    setState(() {
      previousCalculation = '';
      currentCalculation = '$currentCalculation$dataToAdd';
    });
  }

  void deleteData() {
    setState(() {
      previousCalculation = '';
      if (currentCalculation != '') {
        currentCalculation = currentCalculation.substring(
          0,
          currentCalculation.length - 1,
        );
      }
    });
  }

  void deleteAll(){
    setState(() {
      currentCalculation = '';
      previousCalculation = '';
    });
  }

  void calculate(){
    setState(() {
      previousCalculation = currentCalculation;
      currentCalculation = calculationFunction(currentCalculation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StateProvider(
      state: this, 
      child: Layout());
  }
}
