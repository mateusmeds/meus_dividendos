import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dividends/core/dependency_injection.dart';

import 'package:my_dividends/domain/models/announced_dividend_model.dart';

import 'package:my_dividends/presentation/announced_dividends/bloc/announced_dividends_bloc.dart';
import 'package:my_dividends/presentation/announced_dividends/bloc/events/announced_dividends_event.dart';
import 'package:my_dividends/presentation/announced_dividends/bloc/states/announced_dividends_state.dart';
import 'package:my_dividends/presentation/announced_dividends/widgets/header.dart';
import 'package:my_dividends/presentation/announced_dividends/widgets/announced_dividends_list.dart';
import 'package:my_dividends/widgets/export.dart' show LoadingCenter, Menu;

class AnnouncedDividendsPage extends StatefulWidget {
  const AnnouncedDividendsPage({Key? key}) : super(key: key);

  @override
  State<AnnouncedDividendsPage> createState() => _AnnouncedDividendsPageState();
}

class _AnnouncedDividendsPageState extends State<AnnouncedDividendsPage> {
  final _scrollController = ScrollController();
  late final AnnouncedDividendsBloc _announcedDividendsBloc;

  @override
  void initState() {
    _announcedDividendsBloc = getDependency<AnnouncedDividendsBloc>();
    _announcedDividendsBloc.add(GetAllAnnouncedDividendsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dividendos Anunciados'),
      ),
      drawer: const Menu(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return BlocConsumer<AnnouncedDividendsBloc, AnnouncedDividendsState>(
            bloc: _announcedDividendsBloc,
            listener: (context, state) {
              if (state is GetAllAnnouncedDividendsErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is GetAllAnnouncedDividendsLoadingState) {
                return const LoadingCenter();
              }

              if (state is GetAllAnnouncedDividendsSuccessState) {
                List<AnnouncedDividendModel> announcedDividends =
                    state.announcedDividends;
                return ListView(
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Header(dividendCount: announcedDividends.length),
                    AnnouncedDividendsList(
                      announcedDividends: announcedDividends,
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
