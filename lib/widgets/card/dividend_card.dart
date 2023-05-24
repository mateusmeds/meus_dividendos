import 'package:flutter/material.dart';
import 'package:my_dividends/utils/currency_formatter.dart';
import 'package:my_dividends/widgets/export.dart' show RowCard;

class DividendCard extends StatelessWidget {
  const DividendCard({
    Key? key,
    this.value,
    this.received = true,
    this.color,
  }) : super(key: key);

  final double? value;
  final bool received;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return RowCard(
      received ? 'Recebidos' : 'A receber',
      backgroundColor: color ?? Colors.grey[300],
      leading: received
          ? const Icon(Icons.currency_exchange)
          : const Icon(Icons.access_time),
      trailing: Text(
        CurrencyFormatter.toBRL(value ?? 0),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }
}
