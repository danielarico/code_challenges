import 'dart:convert';
import 'dart:io';

void main() {
  const conversionCodes = {
    '11': ' ',
    '1001': 't',
    '10000': 'n',
    '0101': 's',
    '01000': 'r',
    '00101': 'd',
    '001000': '!',
    '000101': 'c',
    '000011': 'm',
    '0000100': 'g',
    '0000010': 'b',
    '00000001': 'v',
    '0000000001': 'k',
    '000000000001': 'q',
    '101': 'e',
    '10001': 'o',
    '011': 'a',
    '01001': 'i',
    '0011': 'h',
    '001001': 'l',
    '00011': 'u',
    '000100': 'f',
    '0000101': 'p',
    '0000011': 'w',
    '0000001': 'y',
    '000000001': 'j',
    '00000000001': 'x',
    '000000000000': 'z'
  };

  const base32Dict = {
    '0': '00000',
    '1': '00001',
    '2': '00010',
    '3': '00011',
    '4': '00100',
    '5': '00101',
    '6': '00110',
    '7': '00111',
    '8': '01000',
    '9': '01001',
    'A': '01010',
    'B': '01011',
    'C': '01100',
    'D': '01101',
    'E': '01110',
    'F': '01111',
    'G': '10000',
    'H': '10001',
    'I': '10010',
    'J': '10011',
    'K': '10100',
    'L': '10101',
    'M': '10110',
    'N': '10111',
    'O': '11000',
    'P': '11001',
    'Q': '11010',
    'R': '11011',
    'S': '11100',
    'T': '11101',
    'U': '11110',
    'V': '11111',
  };

  List<String> input = getInput();
  String base32toBin = base32ToBin(input, base32Dict);
  List<String> decoded = decode(base32toBin, conversionCodes, 0, 1, []);
  print(decoded.join(''));
}

List<String> getInput() {
  Encoding encoding = Encoding.getByName('utf-8');
  return stdin.readLineSync(encoding: encoding).split('');
}

String base32ToBin(List<String> base32List, Map<String, String> base32Dict) {
  List<String> binArray = [];
  for (int i = 0; i < base32List.length; i++) {
    binArray.add(base32Dict[base32List[i]]);
  }
  String binString = binArray.join('');
  return (binString);
}

List<String> decode(String binString, Map<String, String> conversionCodes,
    int start, int end, List<String> currentDecoded) {
  int newStart, newEnd;
  String currentSubstring = binString.substring(start, end);

  if (end == binString.length) {
    if (conversionCodes.containsKey(currentSubstring)) {
      currentDecoded.add(conversionCodes[currentSubstring]);
      return (currentDecoded);
    } else {
      return (currentDecoded);
    }
  } else {
    if (conversionCodes.containsKey(currentSubstring)) {
      newStart = end;
      newEnd = newStart + 1;
      currentDecoded.add(conversionCodes[currentSubstring]);
      return (decode(
          binString, conversionCodes, newStart, newEnd, currentDecoded));
    } else {
      newEnd = end + 1;
      return (decode(
          binString, conversionCodes, start, newEnd, currentDecoded));
    }
  }
}

/*
$ cat DATA.lst | dart danielaricoa.dart
world !he has refused his !assent to !laws the most wholesome and necessary
for waging !war against us !he has plundered our seas ravaged our coasts burnt
as to them shall seem most likely to effect their !safety and !happiness
*/
