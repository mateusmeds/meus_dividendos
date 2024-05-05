import 'package:dartz/dartz.dart';
import 'package:my_dividends/domain/models/dividend_history_model.dart';
import 'package:my_dividends/domain/models/dividend_model.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/domain/models/stock_negotiation_model.dart';
import 'package:my_dividends/domain/repositories/my_dividends_repository.dart';
import 'package:my_dividends/services/dividends/utils.dart';

class CalculateDividendHistoryPerStock {
  CalculateDividendHistoryPerStock(this._myDividendsRepository);

  final MyDividendsRepository _myDividendsRepository;

  Future<Either<Exception, List<DividendHistoryModel>>> call(
      StockModel stock) async {
    try {
      var stockNegotiationsOutput = await _myDividendsRepository
          .getAllStockNegotiationsByTicker(stock.ticker!);
      List<StockNegotiationModel> stockNegotiations = stockNegotiationsOutput
          .toOption()
          .toNullable() as List<StockNegotiationModel>;

      List<DividendModel>? dividends = stock.cashDividendsModel!.dividends;

      if (dividends == null) {
        return const Right([]);
      }

      List<DividendModel> dividendsByDateWithFromFirstNegotiationDateList =
          filterDividendsByDateWithFromFirstNegotiationDate(
              dividends, stockNegotiations);

      List<DividendHistoryModel> dividendsCalendar = [];

      for (var dividend in dividendsByDateWithFromFirstNegotiationDateList) {
        double dividends = 0;
        var stockNegotiationsUltilDateWithList =
            filterStockNegotiationsUntilDate(
                stockNegotiations, dividend.dateWith);

        var stocksEntitledToReceiveDividends =
            getQuantityStocksEntitledToReceiveDividends(
                stockNegotiationsUltilDateWithList);

        var dividendsToReceiveByStock = getDividendsToReceiveByStock(
            dividend.value, stocksEntitledToReceiveDividends);

        dividends = dividendsToReceiveByStock * dividend.dividendTax.tax;

        if (dividends > 0) {
          dividendsCalendar.add(
            DividendHistoryModel(
              paymentDate: dividend.paymentDate,
              value: dividends,
            ),
          );
        }
      }

      return Right(dividendsCalendar);
    } on Exception {
      return Left(Exception('Erro ao calcular dividendos a receber por ação'));
    }
  }
}
