String calculationFunction(String input){
  final String americanInput = input.replaceAll(',', '.');
  final regex = RegExp(r'\d+(?:.\d+)?|[-+×÷%]\gm');
  final matches= regex.firstMatch(americanInput);
  //List<String> americanInputList = matches.map((m) => m.group(0)!).toList();
/*
  String result = '0';

  for(String element in americanInputList){
    result += '$element ';
  }
  */
  return 'matches';
}