double calculationFunction(List<String> input) {
  for (int i = 0; i < input.length; i++) {
    if (input[i] == '×' || input[i] == '÷' || input[i] == '%') {
      _calculatePunkt(input, i);
      i = -1;
      continue;
    }
  }

  for (int i = 0; i < input.length; i++) {
    if (input[i] == '-' || input[i] == '+') {
      _calculateStrich(input, i);
      i = -1;
      continue;
    }
  }

  return double.parse(input[0]);
}

void _calculatePunkt(List<String> listToModify, int index) {
  double? result;
  String stringResult;

  switch (listToModify[index]) {
    case '×':
      result =
          (double.parse(listToModify[index - 1]) *
          double.parse(listToModify[index + 1]));
      break;
    case '÷':
      result =
          (double.parse(listToModify[index - 1]) /
          double.parse(listToModify[index + 1]));
      break;
    case '%':
      result =
          (double.parse(listToModify[index - 1]) %
          double.parse(listToModify[index + 1]));
      break;
  }
  stringResult = result.toString();

  listToModify.removeRange(index - 1, index + 2);
  listToModify.insert(index - 1, stringResult);
}

void _calculateStrich(List<String> listToModify, int index) {
  double? result;
  String stringResult;

  switch (listToModify[index]) {
    case '+':
      result =
          (double.parse(listToModify[index - 1]) +
          double.parse(listToModify[index + 1]));
      break;
    case '-':
      result =
          (double.parse(listToModify[index - 1]) -
          double.parse(listToModify[index + 1]));
      break;
  }
  stringResult = result.toString();

  listToModify.removeRange(index - 1, index + 2);
  listToModify.insert(index - 1, stringResult);
}
