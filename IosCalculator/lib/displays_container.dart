import 'package:IosCalculator/history_result_container.dart';
import 'package:IosCalculator/result_container.dart';
import 'package:flutter/material.dart';

class DisplaysContainer extends StatelessWidget {
  const DisplaysContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Stack(
        children: [
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [HistoryResultContainer(), ResultContainer()],
            ),
          ),
          Positioned(
            bottom: 10,
            left: -2,
            child: Container(
              width: 30,
              height: 500,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(255, 36, 39, 39),
                    Color.fromARGB(0, 36, 39, 39),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
