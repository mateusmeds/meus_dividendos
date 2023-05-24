import 'package:dartz/dartz.dart';
import 'package:my_dividends/domain/models/stock_model.dart';

abstract class StockDataSource {
  Future<Either<Exception, bool>> add(StockModel stockModel);

  Future<Either<Exception, bool>> alter(StockModel stockModel);

  Future<Either<Exception, List<StockModel>>> getAll();

  Future<Either<Exception, StockModel>> getById(int key);

  Future<Either<Exception, StockModel?>> getByTicker(String ticker);

  Future<Either<Exception, Map<String, dynamic>>> getIsinCodes(String ticker);
}
