// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_dividends_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashDividendsModel _$CashDividendsModelFromJson(Map<String, dynamic> json) =>
    CashDividendsModel(
      dividends: (json['cashDividends'] as List<dynamic>?)
          ?.map((e) => DividendModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CashDividendsModelToJson(CashDividendsModel instance) =>
    <String, dynamic>{
      'cashDividends': instance.dividends,
    };
