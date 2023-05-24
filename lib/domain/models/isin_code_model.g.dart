// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isin_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IsinCodeModel _$IsinCodeModelFromJson(Map<String, dynamic> json) =>
    IsinCodeModel(
      isinCode: json['isin'] as String,
      ticker: json['code'] as String,
    );

Map<String, dynamic> _$IsinCodeModelToJson(IsinCodeModel instance) =>
    <String, dynamic>{
      'isin': instance.isinCode,
      'code': instance.ticker,
    };
