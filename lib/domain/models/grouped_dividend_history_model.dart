import 'package:my_dividends/domain/models/dividend_history_model.dart';

class GroupedDividendHistoryModel {
  final int year;
  final int month;
  final List<DividendHistoryModel> dividends;

  GroupedDividendHistoryModel({
    required this.year,
    required this.month,
    required this.dividends,
  });
}
