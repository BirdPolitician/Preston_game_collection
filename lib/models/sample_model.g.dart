// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SampleAdapter extends TypeAdapter<Sample> {
  @override
  final int typeId = 3;

  @override
  Sample read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sample(
      height: fields[0] as int?,
      image: fields[1] as dynamic,
      width: fields[2] as int?,
      caption: fields[3] as String?,
      imageType: fields[4] as ImageType,
    );
  }

  @override
  void write(BinaryWriter writer, Sample obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.height)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.width)
      ..writeByte(3)
      ..write(obj.caption)
      ..writeByte(4)
      ..write(obj.imageType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SampleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
