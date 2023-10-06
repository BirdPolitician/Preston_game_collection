import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:preston_game_collection/models/image_type.dart';
part 'sample_model.g.dart';

@HiveType(typeId: 3)
class Sample {
  @HiveField(0)
  final int? height;
  @HiveField(1)
  final dynamic image;
  @HiveField(2)
  final int? width;
  @HiveField(3)
  final String? caption;
  @HiveField(4)
  final ImageType imageType;

  const Sample({
    this.height = 732,
    required this.image,
    this.width = 1044,
    this.caption,
    this.imageType = ImageType.network,
  });

  Image getImage() {
    switch (imageType) {
      case ImageType.network:
        return Image.network(image);
      case ImageType.file:
        return Image.file(image);
    }
  }

  factory Sample.fromJson(Map<String, dynamic> json) => Sample(
        height: json["height"],
        image: json["image"],
        width: json["width"],
        caption: json["caption"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "image": image,
        "width": width,
        "caption": caption,
      };
}
