import 'package:my_dividends/domain/entities/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:my_dividends/domain/models/stock_model.dart';

part 'stock_output_model.g.dart';

@JsonSerializable()
class StockOutputModel extends BaseEntity {
  StockOutputModel({
    this.stocks,
  });

  @JsonKey(name: 'results')
  List<StockModel>? stocks;

  factory StockOutputModel.fromJson(Map<String, dynamic> json) =>
      _$StockOutputModelFromJson(json);

  Map<String, dynamic> toJson() => _$StockOutputModelToJson(this);

  double get currentEquity => stocks!.fold(
      0, (previousValue, element) => previousValue + element.currentTotalValue);
}
