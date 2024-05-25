// ignore_for_file: depend_on_referenced_packages

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;

class Formatters {
  static String formattedMoney(num? val) {
    if (val == 0) {
      return '0';
    }
    final nf = val != 0
        ? NumberFormat("#,###", "en_US")
        : intl.NumberFormat.decimalPattern();

    if (val == null) return '0';
    if (double.parse(val.toStringAsFixed(2)) < 1) {
      return '${double.parse(val.toStringAsFixed(2)) < 0 ? '' : '0'}${nf.format(double.parse(val.toStringAsFixed(2))).replaceAll(',', ' ')}';
    }
    return nf.format(double.parse(val.toStringAsFixed(2))).replaceAll(',', ' ');
  }

  static formatUserNumber(String? number) {
    var buffer = StringBuffer();
    for (int i = 0; i < number!.length; i++) {
      buffer.write(
          i > number.length - 8 && i < number.length - 2 ? '*' : number[i]);
    }
    return buffer.toString();
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue.copyWith(text: '');
    }

    double value = double.parse(newValue.text.replaceAll(RegExp('[^0-9]'), ''));

    String newText = Formatters.formattedMoney(value);

    return newValue.copyWith(
        text: '$newText ${'common.soum'.tr()}',
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class CreditCardNumberFormater extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    String enteredData = newValue.text; // get data enter by used in textField
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < enteredData.length; i++) {
      // add each character into String buffer
      buffer.write(enteredData[i]);
      int index = i + 1;
      if (index % 4 == 0 && enteredData.length != index) {
        // add space after 4th digit
        buffer.write(" ");
      }
    }

    return TextEditingValue(
        text: buffer.toString(), // final generated credit card number
        selection: TextSelection.collapsed(
            offset: buffer.toString().length) // keep the cursor at end
        );
  }
}
