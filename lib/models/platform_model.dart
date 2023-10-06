import 'package:hive/hive.dart';
part 'platform_model.g.dart';

@HiveType(typeId: 2)
class GamePlatform {
  @HiveField(0)
  final String firstReleaseDate;
  @HiveField(1)
  final int? platformId;
  @HiveField(2)
  final String? platformName;

  const GamePlatform({
    this.firstReleaseDate = '2023',
    this.platformId = 0,
    this.platformName = 'PregnancyTest',
  });

  factory GamePlatform.fromJson(Map<String, dynamic> json) => GamePlatform(
        firstReleaseDate: json["first_release_date"],
        platformId: json["platform_id"],
        platformName: json["platform_name"],
      );

  Map<String, dynamic> toJson() => {
        "first_release_date": firstReleaseDate,
        "platform_id": platformId,
        "platform_name": platformName,
      };
}
