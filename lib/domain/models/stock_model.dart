import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:my_dividends/domain/entities/base_entity.dart';
import 'package:my_dividends/domain/models/cash_dividends_model.dart';

part 'stock_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class StockModel extends BaseEntity {
  StockModel({
    this.ticker,
    this.name,
    this.currentQuote,
    this.urlImage,
    this.quantity,
    this.cashDividendsModel,
    this.isinCode,
    this.dividendsReceived,
    this.dividendsToReceive,
  });

  @HiveField(1)
  @JsonKey(name: 'symbol')
  String? ticker;

  @HiveField(2)
  int? quantity;

  @HiveField(3)
  String? isinCode;

  @JsonKey(name: 'longName')
  String? name;

  @JsonKey(name: 'regularMarketPrice')
  double? currentQuote;

  @JsonKey(name: 'logourl')
  String? urlImage;

  @JsonKey(name: 'dividendsData')
  CashDividendsModel? cashDividendsModel;

  double? dividendsReceived;

  double? dividendsToReceive;

  factory StockModel.fromJson(Map<String, dynamic> json) =>
      _$StockModelFromJson(json);

  Map<String, dynamic> toJson() => _$StockModelToJson(this);

  double get currentTotalValue {
    var currentQuote = this.currentQuote ?? 0;
    return currentQuote * quantity!;
  }
}
