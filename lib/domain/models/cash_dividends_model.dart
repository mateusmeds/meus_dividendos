import 'package:my_dividends/domain/models/dividend_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_dividends_model.g.dart';

@JsonSerializable()
class CashDividendsModel {
  CashDividendsModel({
    this.dividends,
  });

  @JsonKey(name: 'cashDividends')
  List<DividendModel>? dividends;

  factory CashDividendsModel.fromJson(Map<String, dynamic> json) =>
      _$CashDividendsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CashDividendsModelToJson(this);
}
