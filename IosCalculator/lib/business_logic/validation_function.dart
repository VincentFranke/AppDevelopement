String validationFunction(String dataToAdd, String currentCalculation) {
  final regex = RegExp(r'\d+(?:,)?(?:\d+)?|[-+×÷%]');
  final Iterable<RegExpMatch> matches = regex.allMatches(currentCalculation);
  List<String> currentCalculationList = matches
      .map((m) => m.group(0)!)
      .toList();

  String result = switch (dataToAdd) {
    String d when d == '-' => _calculateMinus(
      currentCalculationList,
      dataToAdd,
    ),
    String d when d == '%' || d == '÷' || d == '×' || d == '+' =>
      _calculateRechenzeichenWithoutMinus(currentCalculationList, dataToAdd),
    String d when d == ',' => _calculateKomma(
      currentCalculationList,
      dataToAdd,
    ),
    String d when num.tryParse(d) != null => _calculateNumber(
      currentCalculationList,
      dataToAdd,
    ),
    _ => 'Error',
  };

  return result;
}

// Immer alles als String zurückgeben auch das was vorher eingegeben wurde
String _calculateMinus(List<String> currentCalculationList, String dataToAdd) {
  if (currentCalculationList.length <= 1 &&
      currentCalculationList.last == '0') {
    return dataToAdd;
  }

  if (currentCalculationList.last == '-') {
    return currentCalculationList.join();
  }

  if (currentCalculationList.last == '+') {
    currentCalculationList.last = dataToAdd;
    return currentCalculationList.join();
  }

  if (_isRechenzeichenWithoutMinusAndPlus(currentCalculationList.last)) {
    currentCalculationList.add(dataToAdd);
    return currentCalculationList.join();
  }
  currentCalculationList.add(dataToAdd);
  return currentCalculationList.join();
}

String _calculateRechenzeichenWithoutMinus(
  List<String> currentCalculationList,
  String dataToAdd,
) {
  if (currentCalculationList.length <= 1 &&
      currentCalculationList.last == '0') {
    currentCalculationList.add(dataToAdd);
    return currentCalculationList.join();
  }

  if (_isRechenzeichen(currentCalculationList.last)) {
    if (currentCalculationList.length >= 2) {
      // Extra Abschnitt um den Bugg mit unendlichen vielen Rechenzeichen zu verhindern
      if (_isRechenzeichen(
        currentCalculationList[currentCalculationList.length - 2],
      )) {
        currentCalculationList.removeLast();
        currentCalculationList.last = dataToAdd;
        return currentCalculationList.join();
      }
    }
    currentCalculationList.last =
        dataToAdd; // Normales ersetzen des Rechenzeichens
    return currentCalculationList.join();
  }

  currentCalculationList.add(dataToAdd);
  return currentCalculationList.join();
}

String _calculateKomma(List<String> currentCalculationList, String dataToAdd) {
  if (currentCalculationList.length <= 1 &&
      currentCalculationList.last == '0') {
    currentCalculationList.add(dataToAdd);
    return currentCalculationList.join();
  }

  if (_isRechenzeichen(currentCalculationList.last)) {
    currentCalculationList.add('0');
    currentCalculationList.add(',');
    return currentCalculationList.join();
  }

  if (currentCalculationList.last.contains(',')) {
    return currentCalculationList.join();
  }

  currentCalculationList.add(dataToAdd);
  return currentCalculationList.join();
}

String _calculateNumber(List<String> currentCalculationList, String dataToAdd) {
  if (currentCalculationList.length <= 1 &&
      currentCalculationList.last == '0') {
    return dataToAdd;
  }

  currentCalculationList.add(dataToAdd);
  return currentCalculationList.join();
}

bool _isRechenzeichen(String data) {
  if (data == '+' || data == '-' || data == '×' || data == '÷' || data == '%') {
    return true;
  }
  return false;
}

bool _isRechenzeichenWithoutMinusAndPlus(String data) {
  if (data == '×' || data == '÷' || data == '%') {
    return true;
  }
  return false;
}
