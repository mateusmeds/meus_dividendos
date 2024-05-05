// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dividend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DividendModel _$DividendModelFromJson(Map<String, dynamic> json) =>
    DividendModel(
      isinCode: json['isinCode'] as String?,
      value: (json['value'] as num).toDouble(),
      dateWith: DateTime.parse(json['lastDatePrior'] as String),
      announcementDate: DateTime.parse(json['approvedOn'] as String),
      stockDividendType:
          StockDividendTypeExtension.fromName(json['type'] as String),
      paymentDate: json['paymentDate'] == null || json['paymentDate'].isEmpty
          ? null
          : DateTime.parse(json['paymentDate'] as String),
    );

Map<String, dynamic> _$DividendModelToJson(DividendModel instance) =>
    <String, dynamic>{
      'isinCode': instance.isinCode,
      'value': instance.value,
      'paymentDate': instance.paymentDate?.toIso8601String(),
      'lastDatePrior': instance.dateWith.toIso8601String(),
      'approvedOn': instance.announcementDate.toIso8601String(),
      'type': _$StockDividendTypeEnumMap[instance.stockDividendType]!,
    };

const _$StockDividendTypeEnumMap = {
  StockDividendType.dividend: 'dividend',
  StockDividendType.jcp: 'jcp',
  StockDividendType.restCapDin: 'restCapDin',
  StockDividendType.yield: 'yield',
  StockDividendType.none: 'none',
};
