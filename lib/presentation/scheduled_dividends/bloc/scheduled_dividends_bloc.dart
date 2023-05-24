import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dividends/core/dependency_injection.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/domain/repositories/my_dividends_repository.dart';
import 'package:my_dividends/presentation/scheduled_dividends/bloc/events/scheduled_dividends_event.dart';
import 'package:my_dividends/presentation/scheduled_dividends/bloc/states/scheduled_dividends_state.dart';
import 'package:my_dividends/services/dividends/calculate_scheduled_dividends_list.dart';

class ScheduledDividendsBloc
    extends Bloc<ScheduledDividendsEvent, ScheduledDividendsState> {
  ScheduledDividendsBloc(this._myDividendsRepository)
      : super(
          ScheduledDividendsInitialState(),
        ) {
    on<GetAllScheduledDividends>(
        (event, emit) async => await _getAllScheduledDividends(event, emit));
  }

  final MyDividendsRepository _myDividendsRepository;
  final CalculateScheduledDividendsList _calculateScheduledDividendsList =
      getDependency<CalculateScheduledDividendsList>();

  _getAllScheduledDividends(
    GetAllScheduledDividends event,
    Emitter emit,
  ) async {
    emit(GetAllScheduledDividendsLoadingState());
    try {
      final stocksLocalResponse = await _myDividendsRepository.getAllStocks();

      List<StockModel> stocksLocal = stocksLocalResponse.fold(
        (l) => throw Exception(l.toString()),
        (r) => r,
      );

      stocksLocal =
          stocksLocal.where((element) => (element.quantity ?? 0) > 0).toList();

      for (var stock in stocksLocal) {
        var stocksExternalResponse = await _myDividendsRepository
            .getStockByTickerExternal(stock.ticker!);

        var stockExternal = stocksExternalResponse.fold(
          (l) => throw Exception(l.toString()),
          (r) => r,
        );

        stock.cashDividendsModel = stockExternal?.cashDividendsModel;
        stock.urlImage = stockExternal?.urlImage;
      }

      final scheduledDividendsResponse =
          await _calculateScheduledDividendsList(stocksLocal);

      scheduledDividendsResponse.fold(
        (l) => throw Exception(l.toString()),
        (r) => emit(
          GetAllScheduledDividendsSuccessState(
            scheduledDividends: r,
          ),
        ),
      );
    } catch (e) {
      emit(
        GetAllScheduledDividendsErrorState(
          message: e.toString(),
        ),
      );
    }
  }
}
