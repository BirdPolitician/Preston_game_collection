import 'package:flutter/material.dart';
import 'package:preston_game_collection/models/game_model.dart';
import 'package:preston_game_collection/models/image_type.dart';
import 'package:preston_game_collection/models/platform_model.dart';
import 'package:preston_game_collection/models/sample_model.dart';
import 'package:preston_game_collection/pages/home_page.dart';
import 'package:preston_game_collection/utils/global_variables.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(GameAdapter());
  Hive.registerAdapter(SampleAdapter());
  Hive.registerAdapter(GamePlatformAdapter());
  Hive.registerAdapter(ImageTypeAdapter());
  await Hive.openBox('savedGames');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preston\' Game Catalogue',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          primaryColor: highlightColor),
      home: const HomePage(),
    );
  }
}
