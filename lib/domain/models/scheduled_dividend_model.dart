import 'package:my_dividends/domain/models/dividend_model.dart';
import 'package:my_dividends/domain/models/stock_model.dart';

class ScheduledDividendModel {
  ScheduledDividendModel({
    required this.stock,
    required this.dividend,
  });

  final StockModel stock;
  final DividendModel dividend;
}
