import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:preston_game_collection/models/platform_model.dart';
import 'package:preston_game_collection/models/sample_model.dart';
import 'package:preston_game_collection/models/image_type.dart';
part 'game_model.g.dart';

List<Game> gamesFromJson(String str) =>
    List<Game>.from(json.decode(str)["games"].map((x) => Game.fromJson(x)));

// String gamesToJson(Games data) => json.encode(data.toJson());

class Games {
  List<Game> games;

  Games({
    required this.games,
  });

  factory Games.fromJson(Map<String, dynamic> json) => Games(
        games: List<Game>.from(json["games"].map((x) => Game.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //       "games": List<dynamic>.from(games.map((x) => x.toJson())),
  //     };
}

@HiveType(typeId: 1)
class Game {
  @HiveField(0)
  String? description;
  @HiveField(1)
  List<GamePlatform> platforms;
  @HiveField(2)
  Sample? sampleCover;
  @HiveField(3)
  String title;

  Game({
    this.description = 'No Description found :(',
    this.platforms = const [GamePlatform()],
    this.sampleCover = const Sample(
        image:
            'https://external-preview.redd.it/zzgctwJ58xJ6cSerODdCReYJ27-99SoD5RpyFl0Lf1o.png?auto=webp&s=0f04ccc0d9bbfb455cccda349c26ae9e7dc0e4f2',
        imageType: ImageType.network),
    required this.title,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        description: json["description"],
        platforms: List<GamePlatform>.from(
            json["platforms"].map((x) => GamePlatform.fromJson(x))),
        sampleCover: json["sample_cover"] != null
            ? Sample.fromJson(json["sample_cover"])
            : null,
        title: json["title"],
      );

  // Map<String, dynamic> toJson() => {
  //       "description": description,
  //       "platforms": List<dynamic>.from(platforms.map((x) => x.toJson())),
  //       "sample_cover": sampleCover.toJson(),
  //       "title": title,
  //     };
}
