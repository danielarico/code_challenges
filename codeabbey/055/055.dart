/// Script to solve challenge #55 from codeabbey - Matching Words
import 'dart:collection';
import 'dart:io';

void main() {
  /// Finds repeated words and print them sorted alphabetically
  List<String> input = getInput();
  List<String> repeated = findRepeated(input, 0, []);
  List<String> sorted = sortAnswer(repeated);
  print(sorted.join(" "));
}

List<String> getInput() {
  /// Obtains input data
  String input = stdin.readLineSync();
  return (input.split(" "));
}

List<String> findRepeated(List<String> input, int i, List<String> repeated) {
  /// Find repeated words
  if (input[i] == "end") {
    return (repeated);
  }

  int occurrences = input.where((e) => e == input[i]).length;

  if (occurrences > 1) {
    if (!repeated.contains(input[i])) {
      return (findRepeated(input, i + 1, repeated + [input[i]]));
    }
    return (findRepeated(input, i + 1, repeated));
  }
  return (findRepeated(input, i + 1, repeated));
}

List<String> sortAnswer(List<String> answer) {
  /// Sorts answer alphabetically
  return (SplayTreeSet<String>.from(answer).toList());
}

/*
$ cat DATA.lst | dart danielaricoa.dart
bat bax bis bup but byt dep det dex dyk dyx gaf gak gok gop gux jeh jit joc
jus jut jys lat lec lip lis los lyc lyh lyp meq met mik moh myq myx nak nas
nif nof nuk nuq nux rex rif ruh ruk rux ryh vec viq vok vuh vyh zac zax zec
zeq zix zof
*/
