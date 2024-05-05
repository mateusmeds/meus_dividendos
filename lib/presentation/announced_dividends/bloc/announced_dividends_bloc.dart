import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dividends/core/dependency_injection.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/domain/repositories/my_dividends_repository.dart';
import 'package:my_dividends/presentation/announced_dividends/bloc/events/announced_dividends_event.dart';
import 'package:my_dividends/presentation/announced_dividends/bloc/states/announced_dividends_state.dart';
import 'package:my_dividends/services/dividends/calculate_announced_dividends_list.dart';

class AnnouncedDividendsBloc
    extends Bloc<AnnouncedDividendsEvent, AnnouncedDividendsState> {
  AnnouncedDividendsBloc(this._myDividendsRepository)
      : super(
          AnnouncedDividendsInitialState(),
        ) {
    on<GetAllAnnouncedDividendsEvent>(
        (event, emit) async => await _getAllAnnouncedDividends(event, emit));
  }

  final MyDividendsRepository _myDividendsRepository;
  final CalculateAnnouncedDividendsList _calculateAnnouncedDividendsList =
      getDependency<CalculateAnnouncedDividendsList>();

  _getAllAnnouncedDividends(
    GetAllAnnouncedDividendsEvent event,
    Emitter emit,
  ) async {
    emit(GetAllAnnouncedDividendsLoadingState());
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

      final announcedDividendsResponse =
          await _calculateAnnouncedDividendsList(stocksLocal);

      announcedDividendsResponse.fold(
        (l) => throw Exception(l.toString()),
        (r) => emit(
          GetAllAnnouncedDividendsSuccessState(
            announcedDividends: r,
          ),
        ),
      );
    } catch (e) {
      emit(
        GetAllAnnouncedDividendsErrorState(
          message: e.toString(),
        ),
      );
    }
  }
}
