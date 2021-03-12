/// Script to solve challenge #4 from codeabbey - Minimum of Two
import 'dart:io';
import 'dart:math';

void main() {
  /// Find min value for a set of testcases
  int testcasesNumber = getTestcasesNumber();
  List<List<int>> testcases = getTestcases(testcasesNumber, 0, []);
  List<int> answer = findMin(testcases);
  print(answer.join(" "));
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
  List<int> dataInt = dataStr.map((val) => int.parse(val)).toList();
  return (getTestcases(number, i + 1, testcases + [dataInt]));
}

List<int> findMin(List<List<int>> testcases) {
  /// Find min value for each testcase
  return (testcases.map((testcase) => testcase.reduce(min)).toList());
}

/*
$ cat DATA.lst | dart danielaricoa.dart
-6928914 -8100036 -7534406 -3760599 3226485 -6193933 -7575671 -9095216
-7449533 -1120183 -8679588 -2400784 -8853699 -2446291 -4345377 -8100940
-5929975 -6200977 -3464381 -7516554 -3710487 9235145 -9860070
*/
