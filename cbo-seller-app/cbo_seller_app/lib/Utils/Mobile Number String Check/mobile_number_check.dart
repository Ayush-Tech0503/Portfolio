import 'package:flutter/services.dart';
class MobileNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final newText = getNumberString(newValue.text);
    final formattedText = getFormattedMobileNumber(newText);
    int integerValue = int.parse(newText);
    if(integerValue>10)
    {
      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String getNumberString(String inputString) {
    final digitPattern = RegExp(r'\d+'); // Match one or more digits
    final matches = digitPattern.allMatches(inputString);
    final digitsList = matches.map((match) => match.group(0)).cast<String>().toList();
    return digitsList.join();
  }

  String getFormattedMobileNumber(String rawMblNumStr) {
    if (rawMblNumStr.length > 10 ) {
      return rawMblNumStr.substring(rawMblNumStr.length - 10);
    } else {
      return rawMblNumStr;
    }
  }
}
