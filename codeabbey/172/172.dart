/*
$ dartanalyzer danielaricoa.dart
Analyzing danielaricoa.dart...
No issues found!
*/

/// Script to solve challenge #172 from codeabbey - Cloud Altitude Measurement
import 'dart:io';
import 'dart:math';

void main() {
  /// Computes and prints cloud altitudes for a set of testcases
  int testcasesNumber = getTestcasesNumber();
  List<List<double>> testcases = getTestcases(testcasesNumber, 0, []);
  List<int> answer = getAnswer(testcases, 0, []);
  print(answer.join(" "));
}

int getTestcasesNumber() {
  /// Obtains number of testcases
  String number = stdin.readLineSync();
  return int.parse(number);
}

List<List<double>> getTestcases(
    int number, int i, List<List<double>> testcases) {
  /// Reads testcases
  if (i == number) {
    return (testcases);
  }
  List<String> dataStr = stdin.readLineSync().split(" ");
  List<double> dataDouble = dataStr.map((x) => double.parse(x)).toList();
  return (getTestcases(number, i + 1, testcases + [dataDouble]));
}

int findAltitude(List<double> currentTestcase) {
  /// Computes altitude for each testcase
  double d1 = currentTestcase[0];
  double angleA = currentTestcase[1] * pi / 180;
  double angleB = currentTestcase[2] * pi / 180;

  double altitude = (tan(angleA) * d1) / (1.0 - tan(angleA) / tan(angleB));
  return (altitude.round());
}

List<int> getAnswer(List<List<double>> testcases, int i, List<int> answer) {
  /// Computes cloud altitudes for a set of testcases
  if (i == testcases.length) {
    return (answer);
  }
  int altitude = findAltitude(testcases[i]);
  return (getAnswer(testcases, i + 1, answer + [altitude]));
}

/*
$ cat DATA.lst | dart danielaricoa.dart
1731 1044 1069 1743 1866 1971 1185 1925 1352 537 1722 572 1160 1303 1365 837
1684 523
*/
