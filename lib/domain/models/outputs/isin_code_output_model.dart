import 'package:my_dividends/domain/entities/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:my_dividends/domain/models/isin_code_model.dart';

part 'isin_code_output_model.g.dart';

@JsonSerializable()
class IsinCodeOutputModel extends BaseEntity {
  IsinCodeOutputModel({
    this.isinCodes,
  });

  @JsonKey(name: 'otherCodes')
  List<IsinCodeModel>? isinCodes;

  factory IsinCodeOutputModel.fromJson(Map<String, dynamic> json) =>
      _$IsinCodeOutputModelFromJson(json);

  Map<String, dynamic> toJson() => _$IsinCodeOutputModelToJson(this);
}
