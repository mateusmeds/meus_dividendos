import 'package:get_it/get_it.dart';
import 'package:my_dividends/domain/repositories/my_dividends_repository.dart';
import 'package:my_dividends/infra/data_sources/imp/my_dividends_data_source_imp.dart';
import 'package:my_dividends/infra/data_sources/imp/stock_data_source_imp.dart';
import 'package:my_dividends/infra/repositories/imp/my_dividends_repository_imp.dart';
import 'package:my_dividends/infra/data_sources/imp/stock_negotiation_data_source_imp.dart';
import 'package:my_dividends/presentation/add_negotiation/bloc/add_negotiation_bloc.dart';
import 'package:my_dividends/presentation/home/bloc/home_bloc.dart';
import 'package:my_dividends/presentation/scheduled_dividends/bloc/scheduled_dividends_bloc.dart';
import 'package:my_dividends/services/dividends/calculate_dividend_history_per_stock.dart';
import 'package:my_dividends/services/dividends/calculate_dividends_received_by_stock.dart';
import 'package:my_dividends/services/dividends/calculate_dividends_to_receive_by_stock.dart';
import 'package:my_dividends/services/dividends/calculate_scheduled_dividends_list.dart';

class DependencyInjection {
  static void load() {
    registerDependency<MyDividendsRepository>(
      () => MyDividendsRepositoryImp(
        MyDividendsDataSourceImp(),
        StockNegotiationDataSourceImp(),
        StockDataSourceImp(),
      ),
    );

    registerDependency<AddNegotiationBloc>(
      () => AddNegotiationBloc(
        getDependency<MyDividendsRepository>(),
      ),
    );

    registerDependency<HomeBloc>(
      () => HomeBloc(
        getDependency<MyDividendsRepository>(),
      ),
    );

    registerDependency<CalculateDividendsReceivedByStock>(
      () => CalculateDividendsReceivedByStock(
        getDependency<MyDividendsRepository>(),
      ),
    );

    registerDependency<CalculateDividendsToReceiveByStock>(
      () => CalculateDividendsToReceiveByStock(
        getDependency<MyDividendsRepository>(),
      ),
    );

    registerDependency<CalculateDividendHistoryPerStock>(
      () => CalculateDividendHistoryPerStock(
        getDependency<MyDividendsRepository>(),
      ),
    );

    registerDependency<CalculateScheduledDividendsList>(
      () => CalculateScheduledDividendsList(),
    );

    registerDependency<ScheduledDividendsBloc>(
      () => ScheduledDividendsBloc(
        getDependency<MyDividendsRepository>(),
      ),
    );
  }
}

final GetIt _getIt = GetIt.instance;

registerDependency<T extends Object>(FactoryFunc<T> func) {
  if (!_getIt.isRegistered<T>()) {
    _getIt.registerFactory<T>(func);
  }
}

registerLazySingleton<T extends Object>(FactoryFunc<T> func) {
  if (!_getIt.isRegistered<T>()) {
    _getIt.registerLazySingleton<T>(func);
  }
}

T getDependency<T extends Object>() {
  return _getIt.get<T>();
}
