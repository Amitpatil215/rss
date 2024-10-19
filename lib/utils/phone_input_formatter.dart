import 'package:flutter/services.dart';

class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Group digits in blocks of 5
    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i += 5) {
      if (i + 5 <= digitsOnly.length) {
        formatted += '${digitsOnly.substring(i, i + 5)} ';
      } else {
        formatted += digitsOnly.substring(i);
      }
    }

    return TextEditingValue(
      text: formatted.trim(), // Remove any trailing space
      selection: TextSelection.collapsed(offset: formatted.trim().length),
    );
  }
}
