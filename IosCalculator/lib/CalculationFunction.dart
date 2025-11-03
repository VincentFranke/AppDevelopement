String calculationFunction(String input){
  final String americanInput = input.replaceAll(',', '.');
  final regex = RegExp(r'\d+(?:\.\d+)?|[-+×÷%]');
  final Iterable<RegExpMatch> matches= regex.allMatches(americanInput);
  List<String> americanInputList = matches.map((m) => m.group(0)!).toList();

  for(int i = 0; i < americanInputList.length; i++){
    if(americanInputList[i] == '×' || americanInputList[i] == '÷' || americanInputList[i] == '%'){
      _calculatePunkt(americanInputList, i);
      i = -1;
      continue;
    }
  }
  return americanInputList.join();
}

void _calculatePunkt(List<String> listToModify, int index){
  double? result;
  String stringResult;
  
  switch(listToModify[index]){
    case '×':
    result = (double.parse(listToModify[index - 1]) * double.parse(listToModify[index + 1]));
      break;
    case '÷':
    result = (double.parse(listToModify[index - 1]) / double.parse(listToModify[index + 1]));
      break;
    case '%':
    result = (double.parse(listToModify[index - 1]) % double.parse(listToModify[index + 1]));
      break;
  }
  if(result! % 1 == 0) {stringResult = result.toInt().toString();} // um die .0 am ende vom double wegzubekommen
  else {stringResult = result.toString();}

  stringResult = stringResult.replaceAll('.', ',');

  listToModify.removeRange(index - 1, index + 2);
  listToModify.insert(index - 1, stringResult);
}

/* /* void _calculateStrich(list<String> listToModify, int index){
  switch(listToModify[index]){
    case 
  } */
} */