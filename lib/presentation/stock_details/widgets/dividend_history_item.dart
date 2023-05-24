import 'package:flutter/material.dart';
import 'package:my_dividends/domain/models/dividend_history_model.dart';
import 'package:my_dividends/utils/currency_formatter.dart';
import 'package:my_dividends/utils/date_formatter.dart';
import 'package:my_dividends/widgets/export.dart';

class DividendHistoryItem extends StatelessWidget {
  const DividendHistoryItem({
    Key? key,
    required this.dividendHistory,
  }) : super(key: key);

  final DividendHistoryModel dividendHistory;

  @override
  Widget build(BuildContext context) {
    return RowCard(
      CurrencyFormatter.toBRL(dividendHistory.value),
      backgroundColor: Colors.transparent,
      trailing: _getStatusIcon(dividendHistory.received),
      internalPadding: EdgeInsets.zero,
      leading: ColumnCard(
        _getPaymentDayTitle(dividendHistory.paymentDate),
        titleStyle: const TextStyle(
          fontSize: 20,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
        internalPadding: const EdgeInsets.all(8),
        trailing: const Text(
          'DIA',
          style: TextStyle(
            fontSize: 9,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _getPaymentDayTitle(DateTime? date) {
    if (date == null || date.year == 9999) {
      return '-';
    }
    return DateFormatter.formatBr(format: 'dd', date: date);
  }

  Icon _getStatusIcon(bool received) {
    if (received) {
      return const Icon(
        Icons.currency_exchange,
      );
    }
    return const Icon(
      Icons.access_time,
    );
  }
}
