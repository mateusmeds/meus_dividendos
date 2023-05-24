import 'package:dartz/dartz.dart';

abstract class MyDividendsDataSource {
  Future<Either<Exception, Map<String, dynamic>>> getAllAvailableTickers();

  Future<Either<Exception, Map<String, dynamic>>> getStockByTicker(
      String ticker);

  Future<Either<Exception, Map<String, dynamic>>> getStocksByTicker(
      List<String> tickers);
}
