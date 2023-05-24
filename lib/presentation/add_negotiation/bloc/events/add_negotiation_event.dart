import 'package:my_dividends/domain/models/stock_negotiation_model.dart';

abstract class AddNegotiationEvent {}

class GetAllAvailableTickersEvent extends AddNegotiationEvent {}

class SaveNegotiationEvent extends AddNegotiationEvent {
  SaveNegotiationEvent(this.negotiation);
  final StockNegotiationModel negotiation;
}
