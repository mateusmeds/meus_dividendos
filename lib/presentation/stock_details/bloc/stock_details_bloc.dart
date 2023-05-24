import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dividends/core/dependency_injection.dart';
import 'package:my_dividends/domain/models/dividend_history_model.dart';
import 'package:my_dividends/domain/models/grouped_dividend_history_model.dart';
import 'package:my_dividends/presentation/stock_details/bloc/events/stock_details_event.dart';
import 'package:my_dividends/presentation/stock_details/bloc/states/stock_details_state.dart';
import 'package:my_dividends/services/dividends/calculate_dividend_history_per_stock.dart';

class StockDetailsBloc extends Bloc<StockDetailsEvent, StockDetailsState> {
  StockDetailsBloc() : super(StockDetailsInitialState()) {
    on<GetStockDetailsEvent>(
        (event, emit) async => await _getDividendHistory(event, emit));
  }

  final CalculateDividendHistoryPerStock _calculateDividendHistoryPerStock =
      getDependency<CalculateDividendHistoryPerStock>();

  _getDividendHistory(GetStockDetailsEvent event, Emitter emit) async {
    emit(GetStockDetailsLoadingState());

    try {
      final dividendHistoryOutput =
          await _calculateDividendHistoryPerStock(event.stock);

      List<DividendHistoryModel> dividendHistory = dividendHistoryOutput
          .toOption()
          .toNullable() as List<DividendHistoryModel>;

      List<GroupedDividendHistoryModel> groupedDividends = [];

      if (dividendHistory.isNotEmpty) {
        groupedDividends = _groupDividends(dividendHistory);
      }

      emit(GetStockDetailsSuccessState(groupedDividends));
    } catch (e) {
      emit(GetStockDetailsErrorState(e.toString()));
    }
  }

  List<GroupedDividendHistoryModel> _groupDividends(
      List<DividendHistoryModel> dividendHistory) {
    // Crie uma lista de GroupedDividends para armazenar os dividendos agrupados por ano e mês
    List<GroupedDividendHistoryModel> groupedDividendsList = [];

    // Percorra cada DividendHistoryModel na lista e agrupe por ano e mês
    for (DividendHistoryModel dividend in dividendHistory) {
      if (dividend.paymentDate != null) {
        int year = dividend.paymentDate!.year;
        int month = dividend.paymentDate!.month;

        // Encontre o GroupedDividends correto com base no ano e no mês
        GroupedDividendHistoryModel groupedDividends =
            groupedDividendsList.firstWhere(
          (gd) => gd.year == year && gd.month == month,
          orElse: () =>
              GroupedDividendHistoryModel(dividends: [], year: 0, month: 0),
        );

        // Se não houver um GroupedDividends para o ano e mês atual, crie um novo
        if (groupedDividends.year == 0 && groupedDividends.month == 0) {
          groupedDividends = GroupedDividendHistoryModel(
            year: year,
            month: month,
            dividends: [],
          );
          groupedDividendsList.add(groupedDividends);
        }

        // Adicione o dividendo ao GroupedDividends correto
        groupedDividends.dividends.add(dividend);
      }
    }
    return groupedDividendsList;
  }
}
