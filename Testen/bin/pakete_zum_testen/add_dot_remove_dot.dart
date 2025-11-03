String removeDots(String stringWithDots) {
  return stringWithDots.replaceAll('.', '');
}

String addDots(String stringWithoutDots) {
  final regex = RegExp(r'\d+(?:,)?(?:\d+)?|[-+×÷%]');
  final Iterable<RegExpMatch> matches = regex.allMatches(stringWithoutDots);
  List<String> currentCalculationList = matches
      .map((m) => m.group(0)!)
      .toList();
  String stringWithDots = '';

  for (var singleStringWithoutDots in currentCalculationList) {
    if (singleStringWithoutDots == '+' ||
        singleStringWithoutDots == '-' ||
        singleStringWithoutDots == '%' ||
        singleStringWithoutDots == '÷' ||
        singleStringWithoutDots == '×') {
      stringWithDots += singleStringWithoutDots;
      continue;
    }

    List<String> singleStringWithoutDotsSplit = singleStringWithoutDots.split(
      ',',
    );

    List<String> edit = singleStringWithoutDotsSplit[0].split('');

    for (int i = singleStringWithoutDotsSplit[0].length - 1; i >= 1; i--) {
      if ((singleStringWithoutDotsSplit[0].length - i) % 3 == 0) {
        edit.insert(i, '.');
      }
    }

    if (singleStringWithoutDotsSplit.length >= 2 &&
        singleStringWithoutDotsSplit[1] == '') {
      // Falls 187, reinkommt oder so
      stringWithDots += '${edit.join()},';
      continue;
    }
    if (singleStringWithoutDotsSplit.length >= 2 &&
        singleStringWithoutDotsSplit[1] != '') {
      stringWithDots += '${edit.join()},${singleStringWithoutDotsSplit[1]}';
      continue;
    }
    stringWithDots += edit.join();
  }
  return stringWithDots;
}
