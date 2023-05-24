// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_negotiation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockNegotiationModelAdapter extends TypeAdapter<StockNegotiationModel> {
  @override
  final int typeId = 2;

  @override
  StockNegotiationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockNegotiationModel(
      ticker: fields[1] as String,
      date: fields[2] as DateTime,
      pricePerStock: fields[3] as double,
      quantity: fields[4] as int,
      type: fields[5] as StockNegotiationType,
    );
  }

  @override
  void write(BinaryWriter writer, StockNegotiationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.ticker)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.pricePerStock)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockNegotiationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
