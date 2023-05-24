import 'package:flutter/material.dart';
import 'package:my_dividends/utils/currency_formatter.dart';
import 'package:my_dividends/widgets/export.dart' show DividendCard;

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.totalEquity,
    required this.totalDividendsReceived,
    required this.totalDividendsToReceive,
  }) : super(key: key);

  final double totalEquity;
  final double totalDividendsReceived;
  final double totalDividendsToReceive;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Patrimônio'),
        const SizedBox(
          height: 7,
        ),
        Text(
          CurrencyFormatter.toBRL(totalEquity),
          style: const TextStyle(fontSize: 28),
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            const Text(
              'Dividendos',
              textAlign: TextAlign.center,
            ),
            DividendCard(
              value: totalDividendsReceived,
            ),
            DividendCard(
              value: totalDividendsToReceive,
              received: false,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
