// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardEntityAdapter extends TypeAdapter<CardEntity> {
  @override
  final int typeId = 1;

  @override
  CardEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardEntity(
      name: fields[0] as String,
      number: fields[1] as String,
      expirationDate: fields[2] as String,
      cvv: fields[3] as String,
      pin: fields[4] as String,
      cardStatus: fields[5] as CardStatus,
    );
  }

  @override
  void write(BinaryWriter writer, CardEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.expirationDate)
      ..writeByte(3)
      ..write(obj.cvv)
      ..writeByte(4)
      ..write(obj.pin)
      ..writeByte(5)
      ..write(obj.cardStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CardStatusAdapter extends TypeAdapter<CardStatus> {
  @override
  final int typeId = 2;

  @override
  CardStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CardStatus.active;
      case 1:
        return CardStatus.archival;
      default:
        return CardStatus.active;
    }
  }

  @override
  void write(BinaryWriter writer, CardStatus obj) {
    switch (obj) {
      case CardStatus.active:
        writer.writeByte(0);
        break;
      case CardStatus.archival:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
