import 'package:dartz/dartz.dart';
import 'package:my_dividends/domain/models/dividend_model.dart';
import 'package:my_dividends/domain/models/announced_dividend_model.dart';
import 'package:my_dividends/domain/models/stock_model.dart';

class CalculateAnnouncedDividendsList {
  Future<Either<Exception, List<AnnouncedDividendModel>>> call(
      List<StockModel> stocks) async {
    List<AnnouncedDividendModel> announcedDividends = [];
    try {
      for (var stock in stocks) {
        List<DividendModel> dividends =
            stock.cashDividendsModel?.dividends ?? [];

        var announcedDividendsByStock = dividends
            .where((dividend) =>
                dividend.paymentDate == null ||
                dividend.paymentDate!.isAfter(DateTime.now()))
            .toList();

        for (var dividend in announcedDividendsByStock) {
          announcedDividends.add(AnnouncedDividendModel(
            stock: stock,
            dividend: dividend,
          ));
        }
      }

      announcedDividends.sort((a, b) =>
          (a.dividend.paymentDate?.toIso8601String() ?? '')
              .compareTo(b.dividend.paymentDate?.toIso8601String() ?? ''));

      return Right(announcedDividends);
    } on Exception {
      return Left(Exception('Erro ao calcular dividendos a receber por ação'));
    }
  }
}
