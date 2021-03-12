/// Script to solve challenge #094 from codeabbey - Fool's Day 2014
import 'dart:io';
import 'dart:math';

void main() {
  /// Computes the sum of the squares of the elements for a set of test cases
  int testcasesNumber = getTestcasesNumber();
  List<List<int>> testcases = getTestcases(testcasesNumber, 0, []);
  List<int> answer = getAnswer(testcases, 0, []);
  print(answer.join(" "));
}

int getTestcasesNumber() {
  /// Obtains the number of test cases
  String number = stdin.readLineSync();
  return int.parse(number);
}

List<List<int>> getTestcases(int number, int index, List<List<int>> testcases) {
  /// Reads test cases and evals the integrity of the input data
  List<int> dataInt = [];

  if (index == number) {
    return (testcases);
  }

  List<String> dataStr = stdin.readLineSync().split(" ");
  try {
    dataInt = dataStr.map((value) => int.parse(value)).toList();
  } on FormatException {
    print("Values have to be integers");
  }

  return (getTestcases(number, index + 1, testcases + [dataInt]));
}

List<int> getAnswer(List<List<int>> testcases, int index, List<int> answer) {
  /// Computes the sum of the squares of the elements of each test case
  if (index == testcases.length) {
    return (answer);
  }

  List<int> currentTestcase = testcases[index];
  List<int> squared =
      currentTestcase.map((value) => pow(value, 2).toInt()).toList();
  int squaredSum = squared.reduce((a, b) => a + b);

  return (getAnswer(testcases, index + 1, answer + [squaredSum]));
}

/*
$ cat DATA.lst | dart danielaricoa.dart
506 821 923 80 308 1761 343 1041 106 45 855 306 1282 792 1400 2075
*/
