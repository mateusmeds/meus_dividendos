import 'package:flutter/material.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/presentation/stock_details/page/stock_details_page.dart';

import 'package:my_dividends/utils/currency_formatter.dart';
import 'package:my_dividends/widgets/export.dart'
    show BaseCard, DenseCardTile, DividendCard, FutureImage, RowPropertyValue;

class StockItem extends StatelessWidget {
  const StockItem({
    Key? key,
    required this.stock,
  }) : super(key: key);

  final StockModel stock;

  @override
  Widget build(BuildContext context) {
    return DenseCardTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FutureImage(
          urlImage: stock.urlImage,
        ),
      ),
      title: Text(
        '${stock.name}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: 2,
      ),
      subtitle: Text(
        '${stock.ticker}',
        style: TextStyle(
          fontSize: 11,
          color: Colors.grey[800],
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 15,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StockDetailsPage(
              stock: stock,
            ),
          ),
        );
      },
      children: [
        RowPropertyValue(
          property: 'Ações',
          value: '${stock.quantity}',
        ),
        RowPropertyValue(
          property: 'Cotação',
          value: CurrencyFormatter.toBRL(stock.currentQuote!),
        ),
        RowPropertyValue(
          property: 'Valor total',
          value: CurrencyFormatter.toBRL(stock.currentTotalValue),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Dividendos',
        ),
        DividendCard(
          value: stock.dividendsReceived,
        ),
        DividendCard(
          value: stock.dividendsToReceive,
          received: false,
        ),
      ],
    );
  }
}
