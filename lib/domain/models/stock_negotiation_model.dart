import 'package:my_dividends/domain/enums/stock_negotiation_type.dart';

import 'package:hive/hive.dart';
import 'package:my_dividends/domain/entities/base_entity.dart';

part 'stock_negotiation_model.g.dart';

@HiveType(typeId: 2)
class StockNegotiationModel extends BaseEntity {
  StockNegotiationModel({
    required this.ticker,
    required this.date,
    required this.pricePerStock,
    required this.quantity,
    required this.type,
  });

  @HiveField(1)
  String ticker;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  double pricePerStock;
  @HiveField(4)
  int quantity;
  @HiveField(5)
  StockNegotiationType type;

  double get total => pricePerStock * quantity;
}
