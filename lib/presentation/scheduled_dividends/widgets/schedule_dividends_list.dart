import 'package:flutter/material.dart';
import 'package:my_dividends/domain/models/dividend_model.dart';
import 'package:my_dividends/domain/models/scheduled_dividend_model.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/presentation/scheduled_dividends/widgets/schedule_dividends_item.dart';

class ScheduledividendsList extends StatelessWidget {
  const ScheduledividendsList({
    Key? key,
    required this.scheduledDividends,
  }) : super(key: key);

  final List<ScheduledDividendModel> scheduledDividends;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: scheduledDividends.length,
      itemBuilder: (context, index) {
        ScheduledDividendModel scheduledDividend = scheduledDividends[index];
        StockModel stock = scheduledDividend.stock;
        DividendModel dividend = scheduledDividend.dividend;
        return ScheduledividendsItem(
          stock: stock,
          dividend: dividend,
        );
      },
    );
  }
}
