import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:my_dividends/domain/enums/stock_negotiation_type.dart';
import 'package:my_dividends/domain/models/stock_negotiation_model.dart';
import 'package:my_dividends/infra/data_sources/stock_negotiation_data_source.dart';

class StockNegotiationDataSourceImp implements StockNegotiationDataSource {
  StockNegotiationDataSourceImp() {
    _registerAdapter();
  }

  final String nameBox = 'my_dividends_tb_stock_negotiations';

  late Box<StockNegotiationModel> context;

  @override
  Future<Either<Exception, bool>> add(
      StockNegotiationModel stockNegotiationModel) async {
    await _openBox();
    try {
      await context.add(stockNegotiationModel);

      return const Right(true);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, List<StockNegotiationModel>>> getAll() async {
    await _openBox();
    try {
      return Right(context.values.toList());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, StockNegotiationModel>> getById(int key) async {
    await _openBox();
    try {
      var result =
          context.values.where((element) => element.key == key).toList().last;
      return Right(result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, List<StockNegotiationModel>>> getAllByTicker(
      String ticker) async {
    await _openBox();
    try {
      var result = context.values
          .where((stockNegotiation) => stockNegotiation.ticker == ticker)
          .toList();
      return Right(result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<void> _openBox() async {
    try {
      context = await Hive.openBox<StockNegotiationModel>(nameBox);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _registerAdapter() {
    if (!Hive.isAdapterRegistered(StockNegotiationModelAdapter().typeId)) {
      Hive.registerAdapter<StockNegotiationModel>(
          StockNegotiationModelAdapter());

      Hive.registerAdapter<StockNegotiationType>(StockNegotiationTypeAdapter());
    }
  }
}
