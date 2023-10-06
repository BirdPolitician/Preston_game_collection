// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageTypeAdapter extends TypeAdapter<ImageType> {
  @override
  final int typeId = 4;

  @override
  ImageType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ImageType.network;
      case 1:
        return ImageType.file;
      default:
        return ImageType.network;
    }
  }

  @override
  void write(BinaryWriter writer, ImageType obj) {
    switch (obj) {
      case ImageType.network:
        writer.writeByte(0);
        break;
      case ImageType.file:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
