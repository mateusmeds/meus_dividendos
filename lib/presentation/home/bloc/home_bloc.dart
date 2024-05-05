import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dividends/core/dependency_injection.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/domain/models/stock_negotiation_model.dart';
import 'package:my_dividends/domain/repositories/my_dividends_repository.dart';
import 'package:my_dividends/presentation/home/bloc/events/home_event.dart';
import 'package:my_dividends/presentation/home/bloc/states/home_state.dart';
import 'package:my_dividends/services/dividends/calculate_dividends_received_by_stock.dart';
import 'package:my_dividends/services/dividends/calculate_dividends_to_receive_by_stock.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MyDividendsRepository _myDividendsRepository;
  final CalculateDividendsReceivedByStock _calculateDividendsReceivedByStock =
      getDependency<CalculateDividendsReceivedByStock>();
  final CalculateDividendsToReceiveByStock _calculateDividendsToReceiveByStock =
      getDependency<CalculateDividendsToReceiveByStock>();

  HomeBloc(this._myDividendsRepository) : super(HomeInitialState()) {
    on<GetAllStocksEvent>(
        (event, emit) async => await _getAllStocks(event, emit));
  }

  _getAllStocks(GetAllStocksEvent event, Emitter emit) async {
    try {
      emit(GetAllStocksLoadingState());

      final stocksResponse = await _myDividendsRepository.getAllStocks();

      final List<StockModel> stocksLocal =
          stocksResponse.toOption().toNullable() as List<StockModel>;

      final List<StockModel> stocks = [];

      double totalDividendsReceived = 0;
      double totalDividendsToReceive = 0;
      double totalEquity = 0;

      for (var stock in stocksLocal) {
        var stockResponse = await _myDividendsRepository
            .getStockByTickerExternal(stock.ticker!);
        StockModel? stockParse = stockResponse.toOption().toNullable();
        if (stockParse == null) continue;
        stock.currentQuote = stockParse.currentQuote;
        stock.cashDividendsModel = stockParse.cashDividendsModel;
        stock.name = stockParse.name;
        stock.urlImage = stockParse.urlImage;
        await _calculateDividendsReceivedByStocks(stock);
        await _calculateDividendsToReceiveByStocks(stock);

        totalDividendsReceived += stock.dividendsReceived ?? 0;
        totalDividendsToReceive += stock.dividendsToReceive ?? 0;
        totalEquity += stock.currentTotalValue;
        stocks.add(stock);
      }

      List<StockModel> stocksQuantityGreaterThanZero =
          stocks.where((element) => element.quantity! > 0).toList();

      emit(
        GetAllStocksSuccessState(
          stocks: stocksQuantityGreaterThanZero,
          totalDividendsReceived: totalDividendsReceived,
          totalDividendsToReceive: totalDividendsToReceive,
          totalEquity: totalEquity,
        ),
      );
    } catch (e) {
      emit(GetAllStocksErrorState(e.toString()));
    }
  }

  double filterBuyNegotiations(List<StockNegotiationModel> negotiations) {
    return negotiations
        .where((element) => element.type.name == "buy")
        .map((e) => e.quantity * e.pricePerStock)
        .reduce((value, element) => value + element);
  }

  double filterSellNegotiations(List<StockNegotiationModel> negotiations) {
    return negotiations
        .where((element) => element.type.name == "sell")
        .map((e) => e.quantity * e.pricePerStock)
        .reduce((value, element) => value + element);
  }

  double calculateBuyNegotiationMinusSellNegotiation(
    List<StockNegotiationModel> stockNegotiations,
  ) {
    return filterSellNegotiations(stockNegotiations) -
        filterBuyNegotiations(stockNegotiations);
  }

  Future<void> _calculateDividendsReceivedByStocks(StockModel stock) async {
    var t = await _calculateDividendsReceivedByStock(stock);
    t.fold((l) => print(l), (r) => stock.dividendsReceived = r);
  }

  Future<void> _calculateDividendsToReceiveByStocks(StockModel stock) async {
    var t = await _calculateDividendsToReceiveByStock(stock);
    t.fold((l) => print(l), (r) => stock.dividendsToReceive = r);
  }
}
