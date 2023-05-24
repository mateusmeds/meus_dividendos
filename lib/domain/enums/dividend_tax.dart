import 'package:my_dividends/domain/enums/stock_dividend_type.dart';

class DividendTax {
  DividendTax(StockDividendType stockDividendType) {
    switch (stockDividendType) {
      case StockDividendType.jcp:
        tax = 0.85;
        break;
      case StockDividendType.dividend:
        tax = 1.0;
        break;
      case StockDividendType.restCapDin:
        tax = 0.85;
        break;
      case StockDividendType.yield:
        tax = 0.85;
        break;
      case StockDividendType.none:
        tax = 1.0;
        break;
    }
  }
  late double tax;
}
