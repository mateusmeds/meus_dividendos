import 'package:json_annotation/json_annotation.dart';

part 'isin_code_model.g.dart';

@JsonSerializable()
class IsinCodeModel {
  IsinCodeModel({
    required this.isinCode,
    required this.ticker,
  });

  @JsonKey(name: 'isin')
  final String isinCode;
  @JsonKey(name: 'code')
  final String ticker;

  factory IsinCodeModel.fromJson(Map<String, dynamic> json) =>
      _$IsinCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$IsinCodeModelToJson(this);
}
