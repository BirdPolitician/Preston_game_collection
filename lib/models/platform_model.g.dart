// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GamePlatformAdapter extends TypeAdapter<GamePlatform> {
  @override
  final int typeId = 2;

  @override
  GamePlatform read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GamePlatform(
      firstReleaseDate: fields[0] as String,
      platformId: fields[1] as int?,
      platformName: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GamePlatform obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.firstReleaseDate)
      ..writeByte(1)
      ..write(obj.platformId)
      ..writeByte(2)
      ..write(obj.platformName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GamePlatformAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
