import 'package:dartz/dartz.dart';
import 'package:my_dividends/domain/models/stock_negotiation_model.dart';

abstract class StockNegotiationDataSource {
  Future<Either<Exception, bool>> add(
      StockNegotiationModel stockNegotiationModel);

  Future<Either<Exception, List<StockNegotiationModel>>> getAll();

  Future<Either<Exception, StockNegotiationModel>> getById(int key);

  Future<Either<Exception, List<StockNegotiationModel>>> getAllByTicker(
      String ticker);
}
