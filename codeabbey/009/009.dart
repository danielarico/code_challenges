/*
$ dartanalyzer danielaricoa.dart
Analyzing danielaricoa.dart...
No issues found!
*/

/// Script to solve challenge #009 from codeabbey - Triangles
import 'dart:io';

void main() {
  /// Evals if a triangle can be built for a set of testcases
  int testcasesNumber = getTestcasesNumber();
  List<List<int>> testcases = getTestcases(testcasesNumber, 0, []);
  List<int> triangles = evalTriangles(testcases, 0, []);
  print(triangles.join(" "));
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

  if (dataInt.length != 3) {
    throw new Exception("Expecting three values for each testcase");
  }

  return (getTestcases(number, index + 1, testcases + [dataInt]));
}

List<int> evalTriangles(
    List<List<int>> testcases, int index, List<int> evaluated) {
  /// For each test case evals if a triangle can be built given three segments
  if (index == testcases.length) {
    return (evaluated);
  }

  List<int> triangle = testcases[index];

  // Triangle inequality conditions
  bool condition1 = triangle[0] + triangle[1] > triangle[2];
  bool condition2 = triangle[0] + triangle[2] > triangle[1];
  bool condition3 = triangle[1] + triangle[2] > triangle[0];

  if (condition1 && condition2 && condition3) {
    return (evalTriangles(testcases, index + 1, evaluated + [1]));
  }

  return (evalTriangles(testcases, index + 1, evaluated + [0]));
}

/*
$ cat DATA.lst | dart danielaricoa.dart
0 0 0 1 0 1 1 0 0 0 1 0 0 0 1 0 0 0 1 1 0
*/
