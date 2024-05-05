import 'package:flutter/material.dart';
import 'package:my_dividends/domain/models/dividend_model.dart';
import 'package:my_dividends/domain/models/announced_dividend_model.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/presentation/announced_dividends/widgets/announced_dividends_item.dart';

class AnnouncedDividendsList extends StatelessWidget {
  const AnnouncedDividendsList({
    Key? key,
    required this.announcedDividends,
  }) : super(key: key);

  final List<AnnouncedDividendModel> announcedDividends;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: announcedDividends.length,
      itemBuilder: (context, index) {
        AnnouncedDividendModel announcedDividend = announcedDividends[index];
        StockModel stock = announcedDividend.stock;
        DividendModel dividend = announcedDividend.dividend;
        return AnnouncedDividendsItem(
          stock: stock,
          dividend: dividend,
        );
      },
    );
  }
}
