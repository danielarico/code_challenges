/*
$ dartanalyzer danielaricoa.dart
Analyzing danielaricoa.dart...
No issues found!
*/

/// Script to solve challenge #20 from codeabbey - Vowel Count
import 'dart:io';

void main() {
  /// Find number of vowels for a set of testcases
  List<String> vowels = ["a", "e", "i", "o", "u", "y"];
  int testcasesNumber = getTestcasesNumber();
  List<List<String>> testcases = getTestcases(testcasesNumber, 0, []);
  List<List<bool>> vowelsPosition = findVowels(vowels, testcases, 0, []);
  List<int> answer = countVowels(vowelsPosition, 0, []);
  print(answer.join(" "));
}

int getTestcasesNumber() {
  /// Obtains number of testcases
  String number = stdin.readLineSync();
  return int.parse(number);
}

List<List<String>> getTestcases(
    int number, int i, List<List<String>> testcases) {
  /// Reads testcases
  if (i == number) {
    return (testcases);
  }
  List<String> dataStr = stdin.readLineSync().split("");
  return (getTestcases(number, i + 1, testcases + [dataStr]));
}

List<List<bool>> findVowels(List<String> vowels, List<List<String>> testcases,
    int i, List<List<bool>> foundedVowels) {
  /// Find vowels position for each testcase
  if (i == testcases.length) {
    return (foundedVowels);
  }
  List<bool> isVowel =
      testcases[i].map((letter) => vowels.contains(letter)).toList();
  return (findVowels(vowels, testcases, i + 1, foundedVowels + [isVowel]));
}

List<int> countVowels(List<List<bool>> foundedVowels, int i, List<int> count) {
  /// Count number of vowels for each testcase
  if (i == foundedVowels.length) {
    return (count);
  }
  int currentCount = (foundedVowels[i].where((e) => e == true)).length;
  return (countVowels(foundedVowels, i + 1, count + [currentCount]));
}

/*
$ cat DATA.lst | dart danielaricoa.dart
9 2 10 7 7 8 6 8 5 9 9 8 12 11 9
*/
