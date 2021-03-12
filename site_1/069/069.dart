/// Script to solve challenge #69 from codeabbey - Fibonacci Divisibility
import 'dart:io';

void main() {
  /// Prints the index of the firsts non-zero members of Fibonacci sequence
  /// which are evenly divisible by a set of numbers
  int inputsNumber = getInputsNumber();
  List<int> input = getInput(inputsNumber);
  List<int> divisibles = findAnswer(input, 0, 2, []);
  print(divisibles.join(" "));
}

int getInputsNumber() {
  /// Obtains number of testcases
  String number = stdin.readLineSync();
  return int.parse(number);
}

List<int> getInput(int number) {
  /// Reads testcases
  int limit = 10000;
  List<String> inputStr = stdin.readLineSync().split(" ");
  List<int> inputInt = inputStr.map((x) => int.parse(x)).toList();
  Iterable<int> exceedLimit = inputInt.where((element) => element > limit);

  if (exceedLimit.length != 0) {
    throw new Exception("Dividers can't be greater than 10000");
  }
  if (inputInt.length != number) {
    throw new Exception("Expected input: " + number.toString() + " values");
  }
  return (inputInt);
}

List<int> findAnswer(List<int> numbers, int i, int fibo_i, List<int> answer) {
  /// Finds the index of the non-zero members of Fibonacci sequence which
  /// are evenly divisible by each number of the given set
  if (i == numbers.length) {
    return (answer);
  }

  int newAnswer = findDivisible(0, 1, numbers[i], 2);
  return (findAnswer(numbers, i + 1, 2, answer + [newAnswer]));
}

int findDivisible(int modA, int modB, int divider, int fibo_i) {
  /// Returns the index of the first divisible number of the Fibonacci
  /// sequence for a given divider
  if (1 % divider == 0) {
    return (1);
  }

  int newMod = ((modA + modB) % divider).toInt();

  if (newMod == 0) {
    return (fibo_i);
  }
  return (findDivisible(modB, newMod, divider, fibo_i + 1));
}

/*
$ cat DATA.lst | dart danielaricoa.dart
3300 938 300 8178 900 7500 2100 72 1500 2700 2100 3790 2688 2064 684 1246
420 120 840 396 228 3528
*/
