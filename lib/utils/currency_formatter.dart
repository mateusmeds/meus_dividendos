import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String toBRL(double value, {int decimalDigits = 2}) {
    return NumberFormat.currency(
            locale: 'pt_BR', symbol: 'R\$', decimalDigits: decimalDigits)
        .format(value);
  }

  static double stringToDouble(String value) {
    return double.tryParse(value.replaceAll(',', '.')) ?? 0.0;
  }
}
