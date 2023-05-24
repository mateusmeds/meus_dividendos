// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dividend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DividendModel _$DividendModelFromJson(Map<String, dynamic> json) =>
    DividendModel(
      isinCode: json['isinCode'] as String,
      value: (json['rate'] as num).toDouble(),
      dateWith: DateTime.parse(json['lastDatePrior'] as String),
      announcementDate: DateTime.parse(json['approvedOn'] as String),
      stockDividendType:
          StockDividendTypeExtension.fromName(json['label'] as String),
      paymentDate: json['paymentDate'] == null
          ? null
          : DateTime.parse(json['paymentDate'] as String),
    );

Map<String, dynamic> _$DividendModelToJson(DividendModel instance) =>
    <String, dynamic>{
      'isinCode': instance.isinCode,
      'rate': instance.value,
      'paymentDate': instance.paymentDate?.toIso8601String(),
      'lastDatePrior': instance.dateWith.toIso8601String(),
      'approvedOn': instance.announcementDate.toIso8601String(),
      'label': _$StockDividendTypeEnumMap[instance.stockDividendType]!,
    };

const _$StockDividendTypeEnumMap = {
  StockDividendType.dividend: 'dividend',
  StockDividendType.jcp: 'jcp',
  StockDividendType.restCapDin: 'restCapDin',
  StockDividendType.yield: 'yield',
  StockDividendType.none: 'none',
};
