import 'package:flutter/material.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/presentation/home/widgets/stock_item.dart';

class StocksList extends StatelessWidget {
  const StocksList({Key? key, required this.stocks}) : super(key: key);

  final List<StockModel> stocks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Minhas ações (${stocks.length})'),
        const SizedBox(
          height: 7,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: stocks.length,
          itemBuilder: (context, index) {
            StockModel stock = stocks[index];
            return StockItem(stock: stock);
          },
        ),
      ],
    );
  }
}
