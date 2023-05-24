import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);
    final formatter = NumberFormat("#,##0.00", "pt_BR");
    String newText = "R\$ " + formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }

  static double parseCurrencyFormattedStringToDouble(String value) {
    final numberFormat = NumberFormat("#,##0.00", "pt_BR");
    return numberFormat
        .parse(value.replaceAll(RegExp(r'[^0-9,]'), ''))
        .toDouble();
  }
}
