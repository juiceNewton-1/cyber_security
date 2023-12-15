// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PasswordEntityAdapter extends TypeAdapter<PasswordEntity> {
  @override
  final int typeId = 0;

  @override
  PasswordEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PasswordEntity(
      name: fields[0] as String,
      source: fields[1] as String,
      login: fields[2] as String,
      password: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PasswordEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.source)
      ..writeByte(2)
      ..write(obj.login)
      ..writeByte(3)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasswordEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
