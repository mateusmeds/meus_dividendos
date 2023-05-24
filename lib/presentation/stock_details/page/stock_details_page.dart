import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/presentation/stock_details/bloc/events/stock_details_event.dart';
import 'package:my_dividends/presentation/stock_details/bloc/states/stock_details_state.dart';
import 'package:my_dividends/presentation/stock_details/bloc/stock_details_bloc.dart';
import 'package:my_dividends/presentation/stock_details/widgets/dividend_history_list.dart';
import 'package:my_dividends/presentation/stock_details/widgets/header.dart';
import 'package:my_dividends/widgets/export.dart'
    show EmptyList, LoadingCenter, Menu, RowCard;

class StockDetailsPage extends StatefulWidget {
  const StockDetailsPage({Key? key, required this.stock}) : super(key: key);
  final StockModel stock;

  @override
  State<StockDetailsPage> createState() => _StockDetailsPageState();
}

class _StockDetailsPageState extends State<StockDetailsPage> {
  late final StockDetailsBloc _stockDetailsBloc;
  late final ScrollController _scrollController;

  @override
  void initState() {
    _stockDetailsBloc = StockDetailsBloc();
    _stockDetailsBloc.add(GetStockDetailsEvent(widget.stock));
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stock.name!),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return BlocConsumer<StockDetailsBloc, StockDetailsState>(
          bloc: _stockDetailsBloc,
          listener: (context, state) {
            if (state is GetStockDetailsErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is GetStockDetailsLoadingState) {
              return const LoadingCenter();
            }

            if (state is GetStockDetailsSuccessState) {
              return ListView(
                padding: const EdgeInsets.all(
                  20,
                ),
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                children: [
                  Header(
                    stock: widget.stock,
                  ),
                  RowCard(
                    'Histórico de dividendos',
                    margin: EdgeInsets.zero,
                    leading: Icon(
                      Icons.calendar_month,
                      color: Colors.grey[700],
                    ),
                    backgroundColor: Colors.transparent,
                    internalPadding: EdgeInsets.zero,
                  ),
                  DividendHistoryList(
                    dividendHistory: state.dividendHistory,
                    scrollController: _scrollController,
                  ),
                  EmptyList(
                    empty: state.dividendHistory.isEmpty,
                    title: "Nenhum dividendo recebido ou agendado.",
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        );
      }),
    );
  }
}
