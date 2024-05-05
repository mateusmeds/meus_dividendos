import 'package:flutter/material.dart';
import 'package:my_dividends/domain/enums/stock_dividend_type.dart';
import 'package:my_dividends/domain/models/dividend_model.dart';
import 'package:my_dividends/domain/models/stock_model.dart';
import 'package:my_dividends/utils/currency_formatter.dart';
import 'package:my_dividends/utils/date_formatter.dart';
import 'package:my_dividends/widgets/export.dart';

class AnnouncedDividendsItem extends StatelessWidget {
  const AnnouncedDividendsItem({
    Key? key,
    required this.stock,
    required this.dividend,
  }) : super(key: key);

  final StockModel stock;
  final DividendModel dividend;

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
        stock.name!,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: 2,
      ),
      subtitle: Text(
        stock.ticker!,
        style: TextStyle(
          fontSize: 10,
          color: Colors.grey[800],
        ),
      ),
      trailing: Tag(
        StockDividendTypeExtension.fromEnum(
          dividend.stockDividendType,
        ),
      ),
      children: [
        RowPropertyValue(
          property: 'Valor por ação',
          value: CurrencyFormatter.toBRL(
            (dividend.value * dividend.dividendTax.tax),
            decimalDigits: 5,
          ),
        ),
        RowPropertyValue(
          property: 'Data com',
          value: DateFormatter.fromUTCToBr(dividend.dateWith),
        ),
        RowPropertyValue(
          property: 'Data pagamento',
          value: DateFormatter.fromUTCToBr(
            dividend.paymentDate,
          ),
        ),
      ],
    );
  }
}
