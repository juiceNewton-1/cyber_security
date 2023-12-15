// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeModeEntityAdapter extends TypeAdapter<ThemeModeEntity> {
  @override
  final int typeId = 3;

  @override
  ThemeModeEntity read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemeModeEntity.ligth;
      case 1:
        return ThemeModeEntity.dark;
      default:
        return ThemeModeEntity.ligth;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeModeEntity obj) {
    switch (obj) {
      case ThemeModeEntity.ligth:
        writer.writeByte(0);
        break;
      case ThemeModeEntity.dark:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeModeEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
