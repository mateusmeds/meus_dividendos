import 'package:my_dividends/domain/models/available_tickers_model.dart';
import 'package:my_dividends/domain/models/isin_code_model.dart';
import 'package:my_dividends/domain/models/outputs/isin_code_output_model.dart';
import 'package:my_dividends/domain/models/outputs/stock_output_model.dart';
import 'package:dartz/dartz.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/domain/models/stock_negotiation_model.dart';
import 'package:my_dividends/domain/repositories/my_dividends_repository.dart';
import 'package:my_dividends/infra/data_sources/my_dividends_data_source.dart';
import 'package:my_dividends/infra/data_sources/stock_data_source.dart';
import 'package:my_dividends/infra/data_sources/stock_negotiation_data_source.dart';

class MyDividendsRepositoryImp implements MyDividendsRepository {
  final MyDividendsDataSource _myDividendsDataSource;
  final StockNegotiationDataSource _stockNegotiationDataSource;
  final StockDataSource _stockDataSource;

  MyDividendsRepositoryImp(
    this._myDividendsDataSource,
    this._stockNegotiationDataSource,
    this._stockDataSource,
  );

  @override
  Future<Either<Exception, AvailableTickersModel>>
      getAllAvailableTickersExternal() async {
    try {
      var tickers = await _myDividendsDataSource.getAllAvailableTickers();
      return tickers.fold(
          (l) => Left(l), (r) => Right(AvailableTickersModel.fromJson(r)));
    } on Exception {
      return Left(Exception('Error getting tickers'));
    }
  }

  @override
  Future<Either<Exception, StockModel?>> getStockByTicker(String ticker) async {
    try {
      return await _stockDataSource.getByTicker(ticker);
    } on Exception {
      return Left(Exception('Error getting stock'));
    }
  }

  @override
  Future<Either<Exception, bool>> addStockNegotiation(
      StockNegotiationModel stockNegotiationModel) async {
    try {
      return await _stockNegotiationDataSource.add(stockNegotiationModel);
    } on Exception {
      return Left(Exception('Error adding stock negotiation'));
    }
  }

  @override
  Future<Either<Exception, List<StockNegotiationModel>>>
      getAllStockNegotiations() async {
    try {
      return await _stockNegotiationDataSource.getAll();
    } on Exception {
      return Left(Exception('Error getting stock negotiations'));
    }
  }

  @override
  Future<Either<Exception, StockNegotiationModel>> getStockNegotiationById(
      int key) async {
    try {
      return await _stockNegotiationDataSource.getById(key);
    } on Exception {
      return Left(Exception('Error getting stock negotiations'));
    }
  }

  @override
  Future<Either<Exception, bool>> addStock(StockModel stockModel) async {
    try {
      return await _stockDataSource.add(stockModel);
    } on Exception {
      return Left(Exception('Error adding stock'));
    }
  }

  @override
  Future<Either<Exception, bool>> alterStock(StockModel stockModel) async {
    try {
      return await _stockDataSource.alter(stockModel);
    } on Exception {
      return Left(Exception('Error altering stock'));
    }
  }

  @override
  Future<Either<Exception, List<StockModel>>> getAllStocks() async {
    try {
      return await _stockDataSource.getAll();
    } on Exception {
      return Left(Exception('Error getting stocks'));
    }
  }

  @override
  Future<Either<Exception, StockModel>> getStockById(int key) async {
    try {
      return await _stockDataSource.getById(key);
    } on Exception {
      return Left(Exception('Error getting stock'));
    }
  }

  @override
  Future<Either<Exception, List<StockNegotiationModel>>>
      getAllStockNegotiationsByTicker(String ticker) async {
    try {
      return await _stockNegotiationDataSource.getAllByTicker(ticker);
    } on Exception {
      return Left(Exception('Error getting stock negotiations'));
    }
  }

  @override
  Future<Either<Exception, StockModel?>> getStockByTickerExternal(
      String ticker) async {
    try {
      var stock = await _myDividendsDataSource.getStockByTicker(ticker);
      return stock.fold((l) => Left(l), (r) {
        StockOutputModel stockOutputModel = StockOutputModel.fromJson(r);
        return Right(stockOutputModel.stocks!.first);
      });
    } on Exception {
      return Left(Exception('Error getting stock'));
    }
  }

  @override
  Future<Either<Exception, List<StockModel>>> getStocksByTickerExternal(
      List<String> tickers) async {
    try {
      var output = await _myDividendsDataSource.getStocksByTicker(tickers);
      return output.fold((l) => Left(l), (r) {
        StockOutputModel stockOutputModel = StockOutputModel.fromJson(r);

        return Right(stockOutputModel.stocks!);
      });
    } on Exception {
      return Left(Exception('Error getting stock'));
    }
  }

  @override
  Future<Either<Exception, List<IsinCodeModel>>> getIsinCodes(
      String ticker) async {
    try {
      var output = await _stockDataSource.getIsinCodes(ticker);
      return output.fold((l) => Left(l), (r) {
        IsinCodeOutputModel isinCodeOutputModel =
            IsinCodeOutputModel.fromJson(r);

        return Right(isinCodeOutputModel.isinCodes!);
      });
    } on Exception {
      return Left(Exception('Error getting isin codes'));
    }
  }
}
