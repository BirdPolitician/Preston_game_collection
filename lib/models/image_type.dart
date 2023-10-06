import 'package:hive/hive.dart';
part 'image_type.g.dart';

@HiveType(typeId: 4)
enum ImageType {
  @HiveField(0)
  network,
  @HiveField(1)
  file,
}
