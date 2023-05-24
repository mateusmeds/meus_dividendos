// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockModelAdapter extends TypeAdapter<StockModel> {
  @override
  final int typeId = 1;

  @override
  StockModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockModel(
      ticker: fields[1] as String?,
      quantity: fields[2] as int?,
      isinCode: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StockModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.ticker)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.isinCode)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockModel _$StockModelFromJson(Map<String, dynamic> json) => StockModel(
      ticker: json['symbol'] as String?,
      name: json['longName'] as String?,
      currentQuote: (json['regularMarketPrice'] as num?)?.toDouble(),
      urlImage: json['logourl'] as String?,
      quantity: json['quantity'] as int?,
      cashDividendsModel: json['dividendsData'] == null
          ? null
          : CashDividendsModel.fromJson(
              json['dividendsData'] as Map<String, dynamic>),
      isinCode: json['isinCode'] as String?,
      dividendsReceived: (json['dividendsReceived'] as num?)?.toDouble(),
      dividendsToReceive: (json['dividendsToReceive'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StockModelToJson(StockModel instance) =>
    <String, dynamic>{
      'symbol': instance.ticker,
      'quantity': instance.quantity,
      'isinCode': instance.isinCode,
      'longName': instance.name,
      'regularMarketPrice': instance.currentQuote,
      'logourl': instance.urlImage,
      'dividendsData': instance.cashDividendsModel,
      'dividendsReceived': instance.dividendsReceived,
      'dividendsToReceive': instance.dividendsToReceive,
    };
