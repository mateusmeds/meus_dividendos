import 'package:hive/hive.dart';

part 'stock_negotiation_type.g.dart';

@HiveType(typeId: 3)
enum StockNegotiationType {
  @HiveField(0)
  buy,
  @HiveField(1)
  sell,
}
