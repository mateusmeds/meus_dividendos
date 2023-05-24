// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_output_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockOutputModel _$StockOutputModelFromJson(Map<String, dynamic> json) =>
    StockOutputModel(
      stocks: (json['results'] as List<dynamic>?)
          ?.map((e) => StockModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StockOutputModelToJson(StockOutputModel instance) =>
    <String, dynamic>{
      'results': instance.stocks,
    };
