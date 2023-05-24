// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_tickers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableTickersModel _$AvailableTickersModelFromJson(
        Map<String, dynamic> json) =>
    AvailableTickersModel(
      tickers: (json['stocks'] as List<dynamic>?)
          ?.map((e) => TickerModel.fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$AvailableTickersModelToJson(
        AvailableTickersModel instance) =>
    <String, dynamic>{
      'stocks': instance.tickers,
    };
