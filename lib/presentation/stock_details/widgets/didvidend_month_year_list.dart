import 'package:flutter/material.dart';
import 'package:my_dividends/domain/models/dividend_history_model.dart';
import 'package:my_dividends/presentation/stock_details/widgets/dividend_history_item.dart';

class DidvidendMonthYearList extends StatelessWidget {
  const DidvidendMonthYearList({
    Key? key,
    required this.dividends,
    required this.groupTitle,
    required this.scrollController,
  }) : super(key: key);

  final List<DividendHistoryModel> dividends;
  final String groupTitle;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        groupTitle,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          itemCount: dividends.length,
          itemBuilder: (context, index) {
            DividendHistoryModel dividend = dividends[index];
            return DividendHistoryItem(
              dividendHistory: dividend,
            );
          },
        )
      ],
    );
  }
}
