/// Script to solve challenge #26 from codeabbey - Greatest Common Divisor
import 'dart:io';
import 'dart:math';

void main() {
  /// Prints GCD and LCM for a set of testcases
  int testcasesNumber = getTestcasesNumber();
  List<List<int>> testcases = getTestcases(testcasesNumber, 0, []);
  List<List<int>> answer = getAnswer(testcases, 0, []);
  List<String> formattedAnswer = formatAnswer(answer, 0, []);
  print(formattedAnswer.join(" "));
}

int getTestcasesNumber() {
  /// Obtains number of testcases
  String number = stdin.readLineSync();
  return int.parse(number);
}

List<List<int>> getTestcases(int number, int i, List<List<int>> testcases) {
  /// Reads testcases
  if (i == number) {
    return (testcases);
  }
  List<String> dataStr = stdin.readLineSync().split(" ");
  List<int> dataInt = dataStr.map((x) => int.parse(x)).toList();
  return (getTestcases(number, i + 1, testcases + [dataInt]));
}

int findGCD(List<int> currentPair) {
  /// Finds Greatest Common Divisor for a given testcase
  if (currentPair[0] == currentPair[1]) {
    return (currentPair[0]);
  }
  int minor = currentPair.reduce(min);
  int indexMinor = currentPair.indexOf(minor);
  int indexMajor = (currentPair.length - 1) - indexMinor;
  int diff = currentPair[indexMajor] - currentPair[indexMinor];
  List<int> newList = [minor, diff];
  return (findGCD(newList));
}

int findLCM(List<int> currentPair, int gcd) {
  /// Finds Least Common Multiple for a given testcase
  return (currentPair[0] * currentPair[1] ~/ gcd).toInt();
}

List<List<int>> getAnswer(
    List<List<int>> testcases, int i, List<List<int>> answer) {
  /// Finds GCD and LCM for each testcase
  if (i == testcases.length) {
    return (answer);
  }
  int gcd = findGCD(testcases[i]);
  int lcm = findLCM(testcases[i], gcd);
  List<int> newAnswer = [gcd, lcm];
  return (getAnswer(testcases, i + 1, answer + [newAnswer]));
}

List<String> formatAnswer(
    List<List<int>> answer, int i, List<String> formatted) {
  /// Returns formatted answer to be printed
  if (i == answer.length) {
    return (formatted);
  }
  String currentStr =
      "(" + answer[i][0].toString() + " " + answer[i][1].toString() + ")";
  return (formatAnswer(answer, i + 1, formatted + [currentStr]));
}

/*
$ cat DATA.lst | dart danielaricoa.dart
(174 36540) (37 104044) (1 60818) (363 726) (1 1614) (70 36540) (345 15180)
(1 653) (33 165) (1 66738) (3 684) (1 92898) (152 238336) (74 498316)
(85 276675) (64 72192) (56 49392)
*/
