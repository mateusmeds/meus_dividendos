import 'package:my_dividends/domain/models/announced_dividend_model.dart';

abstract class AnnouncedDividendsState {}

class AnnouncedDividendsInitialState extends AnnouncedDividendsState {}

class GetAllAnnouncedDividendsLoadingState extends AnnouncedDividendsState {}

class GetAllAnnouncedDividendsSuccessState extends AnnouncedDividendsState {
  GetAllAnnouncedDividendsSuccessState({
    required this.announcedDividends,
  });
  final List<AnnouncedDividendModel> announcedDividends;
}

class GetAllAnnouncedDividendsErrorState extends AnnouncedDividendsState {
  GetAllAnnouncedDividendsErrorState({
    required this.message,
  });
  final String message;
}
