import 'package:my_dividends/domain/models/scheduled_dividend_model.dart';

abstract class ScheduledDividendsState {}

class ScheduledDividendsInitialState extends ScheduledDividendsState {}

class GetAllScheduledDividendsLoadingState extends ScheduledDividendsState {}

class GetAllScheduledDividendsSuccessState extends ScheduledDividendsState {
  GetAllScheduledDividendsSuccessState({
    required this.scheduledDividends,
  });
  final List<ScheduledDividendModel> scheduledDividends;
}

class GetAllScheduledDividendsErrorState extends ScheduledDividendsState {
  GetAllScheduledDividendsErrorState({
    required this.message,
  });
  final String message;
}
