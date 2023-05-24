import 'package:dartz/dartz.dart';
import 'package:my_dividends/domain/models/dividend_model.dart';
import 'package:my_dividends/domain/models/scheduled_dividend_model.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/services/dividends/utils.dart';

class CalculateScheduledDividendsList {
  Future<Either<Exception, List<ScheduledDividendModel>>> call(
      List<StockModel> stocks) async {
    List<ScheduledDividendModel> scheduledDividends = [];
    try {
      for (var stock in stocks) {
        List<DividendModel>? dividends = stock.cashDividendsModel?.dividends;

        List<DividendModel> dividendsByIsinCodeList =
            filterStockDividendsByIsinCode(stock.isinCode!, dividends ?? []);

        var scheduledDividendsByStock = dividendsByIsinCodeList
            .where((dividend) => dividend.paymentDate!.isAfter(DateTime.now()))
            .toList();

        for (var dividend in scheduledDividendsByStock) {
          scheduledDividends.add(ScheduledDividendModel(
            stock: stock,
            dividend: dividend,
          ));
        }
      }

      scheduledDividends.sort((a, b) => a.dividend.paymentDate!
          .toIso8601String()
          .compareTo(b.dividend.paymentDate!.toIso8601String()));

      return Right(scheduledDividends);
    } on Exception {
      return Left(Exception('Erro ao calcular dividendos a receber por ação'));
    }
  }
}
