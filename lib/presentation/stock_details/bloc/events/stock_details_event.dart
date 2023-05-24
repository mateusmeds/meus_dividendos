import 'package:my_dividends/domain/models/stock_model.dart';

abstract class StockDetailsEvent {}

class GetStockDetailsEvent extends StockDetailsEvent {
  final StockModel stock;

  GetStockDetailsEvent(this.stock);
}
