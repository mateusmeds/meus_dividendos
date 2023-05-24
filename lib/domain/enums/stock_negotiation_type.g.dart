// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_negotiation_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockNegotiationTypeAdapter extends TypeAdapter<StockNegotiationType> {
  @override
  final int typeId = 3;

  @override
  StockNegotiationType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return StockNegotiationType.buy;
      case 1:
        return StockNegotiationType.sell;
      default:
        return StockNegotiationType.buy;
    }
  }

  @override
  void write(BinaryWriter writer, StockNegotiationType obj) {
    switch (obj) {
      case StockNegotiationType.buy:
        writer.writeByte(0);
        break;
      case StockNegotiationType.sell:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockNegotiationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
