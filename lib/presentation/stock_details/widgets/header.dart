import 'package:flutter/material.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/widgets/export.dart'
    show
        DenseCardTile,
        DividendCard,
        DividendInformation,
        ExpansionCardTile,
        FutureImage;

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.stock,
  }) : super(key: key);

  final StockModel stock;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      child: ExpansionCardTile(
        title: Text(
          stock.name!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FutureImage(
            urlImage: stock.urlImage,
          ),
        ),
        subtitle: Text(stock.ticker!, style: const TextStyle(fontSize: 10)),
        children: [
          DividendInformation(
            dividendsReceived: stock.dividendsReceived,
            dividendsToReceive: stock.dividendsToReceive,
          ),
        ],
      ),
    );
  }
}
