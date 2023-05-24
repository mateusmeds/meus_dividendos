import 'package:flutter/material.dart';
import 'package:my_dividends/domain/models/dividend_history_model.dart';
import 'package:my_dividends/domain/models/grouped_dividend_history_model.dart';
import 'package:my_dividends/presentation/stock_details/widgets/didvidend_month_year_list.dart';
import 'package:my_dividends/utils/date_formatter.dart';
import 'package:my_dividends/widgets/export.dart' show RowCard;

class DividendHistoryList extends StatelessWidget {
  const DividendHistoryList({
    Key? key,
    required this.dividendHistory,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;
  final List<GroupedDividendHistoryModel> dividendHistory;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: scrollController,
      itemCount: dividendHistory.length,
      itemBuilder: (context, index) {
        final GroupedDividendHistoryModel grouppedDividendHistory =
            dividendHistory[index];
        final List<DividendHistoryModel> dividends =
            grouppedDividendHistory.dividends;
        String groupTitle = _getGroupTitle(grouppedDividendHistory);
        return DidvidendMonthYearList(
          dividends: dividends,
          groupTitle: groupTitle,
          scrollController: scrollController,
        );
      },
    );
  }

  String _getGroupTitle(GroupedDividendHistoryModel groupedDividend) {
    if (groupedDividend.year == 9999) {
      return '-';
    }

    return DateFormatter.formatBr(
            format: 'MMMM y',
            date: DateTime(groupedDividend.year, groupedDividend.month))
        .toUpperCase();
  }
}
