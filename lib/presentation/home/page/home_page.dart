import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dividends/core/dependency_injection.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/presentation/add_negotiation/page/add_negotiation_page.dart';
import 'package:my_dividends/presentation/home/bloc/events/home_event.dart';
import 'package:my_dividends/presentation/home/bloc/home_bloc.dart';
import 'package:my_dividends/presentation/home/bloc/states/home_state.dart';
import 'package:my_dividends/presentation/home/widgets/header.dart';
import 'package:my_dividends/presentation/home/widgets/stocks_list.dart';
import 'package:my_dividends/widgets/export.dart' show LoadingCenter, Menu;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = getDependency<HomeBloc>();
    _homeBloc.add(GetAllStocksEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _homeBloc.add(GetAllStocksEvent());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meus Dividendos'),
        ),
        drawer: const Menu(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return BlocConsumer<HomeBloc, HomeState>(
              bloc: _homeBloc,
              listener: (context, state) {
                if (state is GetAllStocksErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is GetAllStocksLoadingState) {
                  return const LoadingCenter();
                }
                if (state is GetAllStocksSuccessState) {
                  List<StockModel> stocks = state.stocks;
                  return ListView(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 100,
                    ),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Header(
                        totalEquity: state.totalEquity,
                        totalDividendsReceived: state.totalDividendsReceived,
                        totalDividendsToReceive: state.totalDividendsToReceive,
                      ),
                      StocksList(
                        stocks: stocks,
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }
}
