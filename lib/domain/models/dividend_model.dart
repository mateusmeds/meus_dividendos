import 'package:json_annotation/json_annotation.dart';
import 'package:my_dividends/domain/enums/dividend_tax.dart';
import 'package:my_dividends/domain/enums/stock_dividend_type.dart';

part 'dividend_model.g.dart';

@JsonSerializable()
class DividendModel {
  DividendModel({
    required this.isinCode,
    required this.value,
    required this.dateWith,
    required this.announcementDate,
    required this.stockDividendType,
    this.paymentDate,
  });

  final String isinCode;
  @JsonKey(name: 'rate')
  final double value;
  @JsonKey(name: 'paymentDate')
  final DateTime? paymentDate;
  @JsonKey(name: 'lastDatePrior')
  final DateTime dateWith;
  @JsonKey(name: 'approvedOn')
  final DateTime announcementDate;
  @JsonKey(name: 'label')
  final StockDividendType stockDividendType;

  DividendTax get dividendTax {
    return DividendTax(stockDividendType);
  }

  factory DividendModel.fromJson(Map<String, dynamic> json) =>
      _$DividendModelFromJson(json);

  Map<String, dynamic> toJson() => _$DividendModelToJson(this);
}
