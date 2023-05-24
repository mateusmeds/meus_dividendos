import 'package:my_dividends/domain/models/ticker_model.dart';

abstract class AddNegotiationState {}

class AddNegotiationInitialState extends AddNegotiationState {}

class GetAllAvailableTickersLoadingState extends AddNegotiationState {}

class GetAllAvailableTickersErrorState extends AddNegotiationState {
  final String message;

  GetAllAvailableTickersErrorState(this.message);
}

class GetAllAvailableTickersSuccessState extends AddNegotiationState {
  final List<TickerModel> tickers;

  GetAllAvailableTickersSuccessState(this.tickers);
}

class SaveNegotiationLoadingState extends AddNegotiationState {}

class SaveNegotiationErrorState extends AddNegotiationState {
  final String message;

  SaveNegotiationErrorState(this.message);
}

class SaveNegotiationSuccessState extends AddNegotiationState {}
