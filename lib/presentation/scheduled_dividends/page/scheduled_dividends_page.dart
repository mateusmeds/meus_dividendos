import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dividends/core/dependency_injection.dart';

import 'package:my_dividends/domain/models/scheduled_dividend_model.dart';

import 'package:my_dividends/presentation/scheduled_dividends/bloc/events/scheduled_dividends_event.dart';
import 'package:my_dividends/presentation/scheduled_dividends/bloc/scheduled_dividends_bloc.dart';
import 'package:my_dividends/presentation/scheduled_dividends/bloc/states/scheduled_dividends_state.dart';
import 'package:my_dividends/presentation/scheduled_dividends/widgets/header.dart';
import 'package:my_dividends/presentation/scheduled_dividends/widgets/schedule_dividends_list.dart';
import 'package:my_dividends/widgets/export.dart' show LoadingCenter, Menu;

class ScheduledDividendsPage extends StatefulWidget {
  const ScheduledDividendsPage({Key? key}) : super(key: key);

  @override
  State<ScheduledDividendsPage> createState() => _ScheduledDividendsPageState();
}

class _ScheduledDividendsPageState extends State<ScheduledDividendsPage> {
  final _scrollController = ScrollController();
  late final ScheduledDividendsBloc _scheduledDividendsBloc;

  @override
  void initState() {
    _scheduledDividendsBloc = getDependency<ScheduledDividendsBloc>();
    _scheduledDividendsBloc.add(GetAllScheduledDividends());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dividendos Programados'),
      ),
      drawer: const Menu(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return BlocConsumer<ScheduledDividendsBloc, ScheduledDividendsState>(
            bloc: _scheduledDividendsBloc,
            listener: (context, state) {
              if (state is GetAllScheduledDividendsErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is GetAllScheduledDividendsLoadingState) {
                return const LoadingCenter();
              }

              if (state is GetAllScheduledDividendsSuccessState) {
                List<ScheduledDividendModel> scheduledDividends =
                    state.scheduledDividends;
                return ListView(
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Header(dividendCount: scheduledDividends.length),
                    ScheduledividendsList(
                      scheduledDividends: scheduledDividends,
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
