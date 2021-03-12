/*
$ dartanalyzer danielaricoa.dart
Analyzing danielaricoa.dart...
No issues found!
*/

/// Script to solve challenge #075 from codeabbey - Yacht or Dice Poker
import 'dart:io';
import "dart:collection";

import 'dart:math';

void main() {
  ///
  int testcasesNumber = getTestcasesNumber();
  List<List<int>> testcases = getTestcases(testcasesNumber, 0, []);
  //List<String> answer = getCombinations(testcases, 0, []);
  //print(answer.join(" "));

  List<int> listica1 = [1, 2, 3, 4, 5];
  List<int> listica2 = [1, 2];
  List<bool> contain =
      listica2.map((value) => listica1.contains(value)).toList();
  print(contain);
}

int getTestcasesNumber() {
  /// Obtains the number of test cases
  String number = stdin.readLineSync();
  return int.parse(number);
}

List<List<int>> getTestcases(int number, int index, List<List<int>> testcases) {
  /// Reads test cases and evals the integrity of the input data
  List<int> dataInt = [];
  int dicesNumber = 5;
  int maxValue = 6;

  if (index == number) {
    return (testcases);
  }

  List<String> dataStr = stdin.readLineSync().split(" ");
  try {
    dataInt = dataStr.map((value) => int.parse(value)).toList();
  } on FormatException {
    print("Values have to be integers");
  }

  if (dataInt.length != dicesNumber) {
    throw new Exception("Expecting $dicesNumber integers for each test case");
  }

  int greaterThanSix = dataInt.where((value) => value > maxValue).length;
  if (greaterThanSix >= 1) {
    throw new Exception("Expecting values between zero and six");
  }

  return (getTestcases(number, index + 1, testcases + [dataInt]));
}

List<String> getCombinations(
    List<List<int>> testcases, int index, List<String> combinations) {
  ///
  if (index == testcases.length) {
    return (combinations);
  }

  List<int> currentPlay = testcases[index];
  Map mapped = mapPlay(currentPlay, {}, 0);

  return (getCombinations(testcases, index + 1, combinations));
}

Map<int, int> mapPlay(List<int> play, Map<int, int> mapped, int index) {
  if (index == play.length) {
    return mapped;
  }

  return (mapPlay(play, mapped, index + 1));
}

/*
$ cat DATA.lst | dart danielaricoa.dart
506 821 923 80 308 1761 343 1041 106 45 855 306 1282 792 1400 2075
*/
