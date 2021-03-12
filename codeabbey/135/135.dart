import 'dart:convert';
import 'dart:io';

final conversionCodes = {
  ' ': '11',
  't': '1001',
  'n': '10000',
  's': '0101',
  'r': '01000',
  'd': '00101',
  '!': '001000',
  'c': '000101',
  'm': '000011',
  'g': '0000100',
  'b': '0000010',
  'v': '00000001',
  'k': '0000000001',
  'q': '000000000001',
  'e': '101',
  'o': '10001',
  'a': '011',
  'i': '01001',
  'h': '0011',
  'l': '001001',
  'u': '00011',
  'f': '000100',
  'p': '0000101',
  'w': '0000011',
  'y': '0000001',
  'j': '000000001',
  'x': '00000000001',
  'z': '000000000000'
};
void main() {
  List<String> input = getInput();
  List<String> encodedHex = encodeToHex(encodeToBin(input));
  print(encodedHex.join(' '));
}

List<String> getInput() {
  Encoding encoding = Encoding.getByName('utf-8');
  return stdin.readLineSync(encoding: encoding).split('');
}

List<String> encodeToBin(List<String> input) {
  String encoded = "";
  input.forEach((element) {
    encoded = encoded + conversionCodes[element];
  });
  return (fixLength(splitBin(encoded)));
}

List<String> splitBin(String encodedBin) {
  RegExp exp = new RegExp(r"\d{1,8}");
  Iterable<Match> matches = exp.allMatches(encodedBin);
  List<String> splitted = (matches.map((m) => m.group(0))).toList();
  return (splitted);
}

List<String> fixLength(List<String> splitted) {
  for (int i = 0; i < splitted.length; i++) {
    if (splitted[i].length < 8) {
      splitted[i] = splitted[i].padRight(8, '0');
    }
  }
  return (splitted);
}

List<String> encodeToHex(List<String> encodedBin) {
  List<String> encodedHex = [];
  int toInt;
  String toHex;
  for (int i = 0; i < encodedBin.length; i++) {
    toInt = binToInt(encodedBin[i]);
    toHex = toInt.toRadixString(16).padLeft(2, '0');
    encodedHex.add(toHex);
  }
  return (encodedHex);
}

int binToInt(String bin) {
  return (int.parse(bin, radix: 2));
}

/*
$ cat DATA.lst | dart danielaricoa.dart
60 d8 1e 23 46 40 a6 d1 35 0b b0 51 25 2a 69 80 4e 23 46 1c 56 70 16 48 d8 22
6e 41 2c 1a ee 05 d9 33 50 98 04 c4 1c 0a c3 b0 96 49 20 72 00 23 28 4a b9 68
5b 02 d8 4f 18 66 95 c8 06 92 49 d9 31 85 c4 8a 39 3b cd 80 d1 78 89 c9 d4 a3
88 82 24 5a bb 81 79 3b 89 14 72 77 45 16 53 23 2d e2 27 11 a3 4c 26 c2 53 18
2e 58 e9 87 27 72 20 c3 bb 81 70 40 72 18 e4 e2 84 c8 1e 22 72 74
*/
