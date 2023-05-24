import 'package:intl/intl.dart';

class DateFormatter {
  static DateTime fromBrToUTC(String date) {
    return DateFormat('dd/MM/y').parse(date).toUtc();
  }

  static String fromUTCToBr(DateTime? date) {
    if (date == null || date.year == 9999) {
      return '-';
    }
    return DateFormat('dd/MM/y').format(date);
  }

  static String formatBr({DateTime? date, required String format}) {
    if (date == null || date.year == 9999) {
      return '-';
    }
    return DateFormat(format, 'pt_BR').format(date);
  }
}
