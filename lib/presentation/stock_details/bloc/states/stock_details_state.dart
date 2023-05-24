import 'package:my_dividends/domain/models/grouped_dividend_history_model.dart';

abstract class StockDetailsState {}

class StockDetailsInitialState extends StockDetailsState {}

class GetStockDetailsLoadingState extends StockDetailsState {}

class GetStockDetailsSuccessState extends StockDetailsState {
  final List<GroupedDividendHistoryModel> dividendHistory;

  GetStockDetailsSuccessState(this.dividendHistory);
}

class GetStockDetailsErrorState extends StockDetailsState {
  final String message;

  GetStockDetailsErrorState(this.message);
}
