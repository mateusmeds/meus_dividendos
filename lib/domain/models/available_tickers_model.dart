import 'package:json_annotation/json_annotation.dart';
import 'package:my_dividends/domain/models/ticker_model.dart';

part 'available_tickers_model.g.dart';

@JsonSerializable()
class AvailableTickersModel {
  AvailableTickersModel({
    this.tickers,
  });

  @JsonKey(name: 'stocks')
  List<TickerModel>? tickers;

  factory AvailableTickersModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableTickersModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableTickersModelToJson(this);
}
