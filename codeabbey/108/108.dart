/*
$ dartanalyzer danielaricoa.dart
Analyzing danielaricoa.dart...
No issues found!
*/

/// Script to solve challenge #108 from codeabbey - Star Medals
import 'dart:io';
import 'dart:math';

void main() {
  /// Finds and prints gems number given N and T for a set of testcases
  int testcasesNumber = getTestcasesNumber();
  List<List<int>> testcases = getTestcases(testcasesNumber, 0, []);
  List<int> gemsNumber = findGemsNumber(testcases, 0, []);
  print(gemsNumber.join(" "));
}

int getTestcasesNumber() {
  /// Obtains number of testcases
  String number = stdin.readLineSync();
  return int.parse(number);
}

List<List<int>> getTestcases(int number, int index, List<List<int>> testcases) {
  /// Reads testcases
  List<int> dataInt = [];
  int gcd;

  if (index == number) {
    return (testcases);
  }

  List<String> dataStr = stdin.readLineSync().split(" ");
  try {
    dataInt = dataStr.map((value) => int.parse(value)).toList();
  } on FormatException {
    print("Values have to be integers");
  }

  if (dataInt.length != 2) {
    throw new Exception("Expecting two values for each testcase");
  } else {
    gcd = findGCD(dataInt);
    if (gcd != 1) {
      throw new Exception("Numbers have to be coprime");
    }
  }

  return (getTestcases(number, index + 1, testcases + [dataInt]));
}

int findGCD(List<int> numbers) {
  /// Finds Greatest Common Divisor between two integers
  if (numbers[0] == numbers[1]) {
    return (numbers[0]);
  }

  int minor = numbers.reduce(min);
  int indexMinor = numbers.indexOf(minor);
  int indexMajor = (numbers.length - 1) - indexMinor;
  int diff = numbers[indexMajor] - numbers[indexMinor];
  List<int> newList = [minor, diff];
  return (findGCD(newList));
}

List<int> findGemsNumber(
    List<List<int>> testcases, int index, List<int> gemsNum) {
  /// Finds and prints gems number for each testcase
  if (index == testcases.length) {
    return (gemsNum);
  }

  int nRays = testcases[index][0];
  int tSteps = testcases[index][1];
  int gems = nRays * (tSteps - 1);

  return (findGemsNumber(testcases, index + 1, gemsNum + [gems]));
}

/*
$ cat DATA.lst | dart danielaricoa.dart
32 9 7 22 44 27 51
*/
