// bloc class using add_negotiation_event.dart and add_negotiation_state.dart

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:my_dividends/domain/enums/stock_negotiation_type.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/domain/models/stock_negotiation_model.dart';
import 'package:my_dividends/domain/repositories/my_dividends_repository.dart';
import 'package:my_dividends/presentation/add_negotiation/bloc/events/add_negotiation_event.dart';
import 'package:my_dividends/presentation/add_negotiation/bloc/states/add_negotiation_state.dart';

class AddNegotiationBloc
    extends Bloc<AddNegotiationEvent, AddNegotiationState> {
  final MyDividendsRepository myDividendsRepository;

  AddNegotiationBloc(this.myDividendsRepository)
      : super(AddNegotiationInitialState()) {
    on<GetAllAvailableTickersEvent>(
      (event, emit) async => await _getAllAvailableTickers(event, emit),
    );
    on<SaveNegotiationEvent>(
      (event, emit) async => await _saveNegotiation(event, emit),
    );
  }

  _getAllAvailableTickers(
    GetAllAvailableTickersEvent event,
    Emitter emit,
  ) async {
    emit(GetAllAvailableTickersLoadingState());
    final result = await myDividendsRepository.getAllAvailableTickersExternal();
    // var teste = await myDividendsRepository.getAllStocks();
    // teste.fold((l) => print(l), (r) {
    //   r.forEach((stock) {
    //     print('############################');
    //     print(stock.ticker);
    //     print(stock.quantity);
    //     print(stock.isinCode);
    //   });
    // });

    // var ti = await myDividendsRepository.getAllStockNegotiations();
    // ti.fold((l) => print(l), (r) {
    //   r.forEach((negotiation) {
    //     print('############################');
    //     print(negotiation.ticker);
    //     print(negotiation.quantity);
    //     print(negotiation.type);
    //     print(negotiation.pricePerStock);
    //     print(negotiation.date);
    //   });
    // });
    emit(result.fold(
      (exception) => GetAllAvailableTickersErrorState(exception.toString()),
      (output) => GetAllAvailableTickersSuccessState(output.tickers!),
    ));
  }

  _saveNegotiation(
    SaveNegotiationEvent event,
    Emitter emit,
  ) async {
    emit(SaveNegotiationLoadingState());

    var saveStockResponse = await _saveStock(event.negotiation);

    if (saveStockResponse.isLeft()) {
      emit(SaveNegotiationErrorState("Erro ao salvar ação"));
    } else {
      final result =
          await myDividendsRepository.addStockNegotiation(event.negotiation);
      emit(result.fold(
        (exception) => SaveNegotiationErrorState(exception.toString()),
        (output) => SaveNegotiationSuccessState(),
      ));
    }
  }

  Future<Either<Exception, bool>> _saveStock(
      StockNegotiationModel negotiation) async {
    try {
      var stockOutput =
          await myDividendsRepository.getStockByTicker(negotiation.ticker);

      StockModel? stockResponse = stockOutput.toOption().toNullable();

      if (stockResponse == null) {
        var isinCodeOutput =
            await myDividendsRepository.getIsinCodes(negotiation.ticker);

        isinCodeOutput.fold((l) => print(l), (r) async {
          String isinCode = '';
          for (var item in r) {
            if (item.ticker == negotiation.ticker) {
              isinCode = item.isinCode;
              break;
            }
          }
          print('isinCode: $isinCode');
          if (isinCode.isEmpty) {
            return Left(Exception('Erro ao pesquisar isin code'));
          }
          var result = await _addStock(negotiation, isinCode);

          if (!result) {
            return Left(Exception('Erro ao adicionar ação'));
          }
        });
      } else {
        var result = await _alterStock(negotiation, stockResponse);
        if (!result) {
          return Left(Exception('Erro ao alterar ação'));
        }
      }
      return const Right(true);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  Future<bool> _addStock(
      StockNegotiationModel negotiation, String isinCode) async {
    var result = await myDividendsRepository.addStock(
      StockModel(
        ticker: negotiation.ticker,
        quantity: negotiation.quantity,
        isinCode: isinCode,
      ),
    );

    return result.isLeft() ? false : true;
  }

  Future<bool> _alterStock(
      StockNegotiationModel negotiation, StockModel stock) async {
    stock.quantity = negotiation.type == StockNegotiationType.buy
        ? stock.quantity! + negotiation.quantity
        : stock.quantity! - negotiation.quantity;
    var result = await myDividendsRepository.alterStock(stock);

    return result.isLeft() ? false : true;
  }
}
