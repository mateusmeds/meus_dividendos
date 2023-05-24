import 'package:my_dividends/domain/enums/stock_negotiation_type.dart';
import 'package:my_dividends/domain/models/dividend_model.dart';
import 'package:my_dividends/domain/models/stock_negotiation_model.dart';

List<StockNegotiationModel> filterStockNegotiationsByBuy(
    List<StockNegotiationModel> stockNegotiations) {
  return stockNegotiations
      .where((e) => e.type == StockNegotiationType.buy)
      .toList();
}

List<StockNegotiationModel> filterStockNegotiationsBySell(
    List<StockNegotiationModel> stockNegotiations) {
  return stockNegotiations
      .where((e) => e.type == StockNegotiationType.sell)
      .toList();
}

List<DividendModel> filterStockDividendsByIsinCode(
    String isinCode, List<DividendModel> dividends) {
  return dividends.where((dividend) => dividend.isinCode == isinCode).toList();
}

int getQuantityStocksEntitledToReceiveDividends(
    List<StockNegotiationModel> stockNegotiations) {
  return getQuantityStocksBuy(stockNegotiations) -
      getQuantityStocksSell(stockNegotiations);
}

double getDividendsToReceiveByStock(double value, int quantityStocks) {
  return value * quantityStocks;
}

int getQuantityStocksSell(List<StockNegotiationModel> stockNegotiations) {
  List<StockNegotiationModel> stockNegotiationsSell =
      filterStockNegotiationsBySell(stockNegotiations);
  return stockNegotiationsSell.isNotEmpty
      ? stockNegotiationsSell
          .map((stockNegotiation) => stockNegotiation.quantity)
          .reduce((value, element) => value + element)
      : 0;
}

List<StockNegotiationModel> filterStockNegotiationsUntilDate(
    List<StockNegotiationModel> stockNegotiations, DateTime date) {
  return stockNegotiations
      .where((stockNegotiation) =>
          stockNegotiation.date.isBefore(date) ||
          stockNegotiation.date.isAtSameMomentAs(date))
      .toList();
}

int getQuantityStocksBuy(List<StockNegotiationModel> stockNegotiations) {
  List<StockNegotiationModel> stockNegotiationsBuy =
      filterStockNegotiationsByBuy(stockNegotiations);

  return stockNegotiationsBuy.isNotEmpty
      ? stockNegotiationsBuy
          .map((stockNegotiation) => stockNegotiation.quantity)
          .reduce((value, element) => value + element)
      : 0;
}

List<DividendModel> filterDividendsByDateWithFromFirstNegotiationDate(
    List<DividendModel> dividends,
    List<StockNegotiationModel> stocksNegotiation) {
  DateTime firstNegotiationDate = getFirstNegotiationDate(stocksNegotiation);
  return dividends
      .where((dividend) =>
          dividend.dateWith.isAfter(firstNegotiationDate) ||
          dividend.dateWith.isAtSameMomentAs(firstNegotiationDate))
      .toList();
}

DateTime getFirstNegotiationDate(
    List<StockNegotiationModel> stockNegotiations) {
  return stockNegotiations
      .map((stockNegotiation) => stockNegotiation.date)
      .reduce((value, element) => value.isBefore(element) ? value : element);
}
