import 'pakete_zum_testen/add_dot_remove_dot.dart';

void main() {
  String input = '0.0323,3423';
  String result = removeDots(input);
  print(result);

  String inputWithoutDots = '1234684,8979437-543820,23-23455,234322';
  print(addDots(inputWithoutDots));
}
