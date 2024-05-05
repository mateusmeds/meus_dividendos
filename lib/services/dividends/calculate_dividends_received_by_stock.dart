import 'package:dartz/dartz.dart';
import 'package:my_dividends/domain/models/dividend_model.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/domain/models/stock_negotiation_model.dart';
import 'package:my_dividends/domain/repositories/my_dividends_repository.dart';
import 'package:my_dividends/services/dividends/utils.dart';

class CalculateDividendsReceivedByStock {
  CalculateDividendsReceivedByStock(this._myDividendsRepository);

  final MyDividendsRepository _myDividendsRepository;

  Future<Either<Exception, double>> call(StockModel stock) async {
    try {
      var stockNegotiationsOutput = await _myDividendsRepository
          .getAllStockNegotiationsByTicker(stock.ticker!);

      List<StockNegotiationModel> stockNegotiations = stockNegotiationsOutput
          .toOption()
          .toNullable() as List<StockNegotiationModel>;

      List<DividendModel>? dividends = stock.cashDividendsModel!.dividends;

      if (dividends == null) {
        return const Right(0);
      }

      // List<DividendModel> dividendsByIsinCodeList =
      //     filterStockDividendsByIsinCode(stock.isinCode!, dividends);

      List<DividendModel> dividendsByDateWithFromFirstNegotiationDateList =
          filterDividendsByDateWithFromFirstNegotiationDate(
              dividends, stockNegotiations);

      List<DividendModel> dividendsOnDayOrAfterPaymentDateList =
          _filterDividendsInTheDayOrAfterPaymentDate(
              dividendsByDateWithFromFirstNegotiationDateList);

      double dividendsToReceive = 0;

      for (var dividend in dividendsOnDayOrAfterPaymentDateList) {
        var stockNegotiationsUltilDateWithList =
            filterStockNegotiationsUntilDate(
                stockNegotiations, dividend.dateWith);

        var stocksEntitledToReceiveDividends =
            getQuantityStocksEntitledToReceiveDividends(
                stockNegotiationsUltilDateWithList);

        var dividendsReceivedByStock = getDividendsToReceiveByStock(
            dividend.value, stocksEntitledToReceiveDividends);

        dividendsToReceive +=
            dividendsReceivedByStock * dividend.dividendTax.tax;
      }

      return Right(dividendsToReceive);
    } on Exception {
      return Left(Exception('Erro ao calcular dividendos a receber por ação'));
    }
  }

  List<DividendModel> _filterDividendsInTheDayOrAfterPaymentDate(
      List<DividendModel> dividends) {
    var date = DateTime.now();

    return dividends
        .where((dividend) =>
            dividend.paymentDate != null &&
            (dividend.paymentDate!.isBefore(date) ||
                dividend.paymentDate!.isAtSameMomentAs(date)))
        .toList();
  }
}
