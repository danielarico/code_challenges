/*
$ dartanalyzer danielaricoa.dart
Analyzing danielaricoa.dart...
No issues found!
*/

/// Script to solve challenge #029 from codeabbey - Sort with Indexes
import 'dart:io';
import "dart:collection";

void main() {
  /// Sorts array elements and prints the original indexes
  int testcasesNumber = getTestcasesNumber();
  List<int> testcases = getTestcases(testcasesNumber, []);
  Map<int, int> originalIndexes = saveIndexes(testcases, 0, {});
  List<int> sortedIndexes = getSortedIndexes(originalIndexes);
  print(sortedIndexes.join(" "));
}

int getTestcasesNumber() {
  /// Obtains the number of test cases
  String number = stdin.readLineSync();
  return int.parse(number);
}

List<int> getTestcases(int number, List<int> testcases) {
  /// Reads test cases and evals the integrity of the input data
  List<int> dataInt = [];

  List<String> dataStr = stdin.readLineSync().split(" ");
  try {
    dataInt = dataStr.map((value) => int.parse(value)).toList();
  } on FormatException {
    print("Values have to be integers");
  }

  if (dataInt.length != number) {
    throw new Exception("Expecting $number integers");
  }

  return (dataInt);
}

Map<int, int> saveIndexes(
    List<int> testcases, int index, Map<int, int> indexMap) {
  /// Save in a Map the original indexes for the array elements
  if (index == testcases.length) {
    return (indexMap);
  }

  Map<int, int> newElement = {testcases[index]: index + 1};

  Map<int, int> newMap = {
    ...indexMap,
    ...newElement,
  };

  return (saveIndexes(testcases, index + 1, newMap));
}

List<int> getSortedIndexes(Map<int, int> indexes) {
  /// Sorts array elements and returns the original indexes
  SplayTreeMap<int, int> sortered = SplayTreeMap.from(indexes);
  return (sortered.values.toList());
}

/*
$ cat DATA.lst | dart danielaricoa.dart
6 5 2 15 14 21 1 10 22 11 23 20 7 17 8 4 19 16 18 9 13 12 3
*/
