import 'package:dartz/dartz.dart';
import 'package:my_dividends/domain/models/available_tickers_model.dart';
import 'package:my_dividends/domain/models/isin_code_model.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/domain/models/stock_negotiation_model.dart';

abstract class MyDividendsRepository {
  Future<Either<Exception, AvailableTickersModel>>
      getAllAvailableTickersExternal();

  Future<Either<Exception, StockModel?>> getStockByTicker(String ticker);

  Future<Either<Exception, bool>> addStockNegotiation(
      StockNegotiationModel stockNegotiationModel);

  Future<Either<Exception, List<StockNegotiationModel>>>
      getAllStockNegotiations();

  Future<Either<Exception, StockNegotiationModel>> getStockNegotiationById(
      int key);

  Future<Either<Exception, bool>> addStock(StockModel stockModel);

  Future<Either<Exception, bool>> alterStock(StockModel stockModel);

  Future<Either<Exception, List<StockModel>>> getAllStocks();

  Future<Either<Exception, StockModel>> getStockById(int key);

  Future<Either<Exception, List<StockNegotiationModel>>>
      getAllStockNegotiationsByTicker(String ticker);

  Future<Either<Exception, StockModel?>> getStockByTickerExternal(
      String ticker);

  Future<Either<Exception, List<StockModel>>> getStocksByTickerExternal(
      List<String> tickers);

  Future<Either<Exception, List<IsinCodeModel>>> getIsinCodes(String ticker);
}
