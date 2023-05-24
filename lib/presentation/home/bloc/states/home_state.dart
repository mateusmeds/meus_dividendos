import 'package:my_dividends/domain/models/stock_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class GetAllStocksLoadingState extends HomeState {}

class GetAllStocksSuccessState extends HomeState {
  final List<StockModel> stocks;
  final double totalDividendsReceived;
  final double totalDividendsToReceive;
  final double totalEquity;

  GetAllStocksSuccessState({
    required this.stocks,
    required this.totalDividendsReceived,
    required this.totalDividendsToReceive,
    required this.totalEquity,
  });
}

class GetAllStocksErrorState extends HomeState {
  final String message;

  GetAllStocksErrorState(this.message);
}
