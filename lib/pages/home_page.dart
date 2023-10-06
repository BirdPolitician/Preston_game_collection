import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:preston_game_collection/models/game_model.dart';
import 'package:preston_game_collection/models/image_type.dart';
import 'package:preston_game_collection/models/platform_model.dart';
import 'package:preston_game_collection/models/sample_model.dart';
import 'package:preston_game_collection/widgets/game_card.dart';
import 'package:preston_game_collection/utils/global_variables.dart';
import 'package:preston_game_collection/utils/text_field.dart';
import 'package:preston_game_collection/services/services.dart';
import 'package:html/parser.dart';
import 'package:preston_game_collection/widgets/my_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum LoadingState { noteEvenTrying, loading, done }

class _HomePageState extends State<HomePage> {
  TextEditingController searchBarController = TextEditingController();
  TextEditingController gameTitleController = TextEditingController();
  TextEditingController gameDescriptionController = TextEditingController();
  TextEditingController gameDateController = TextEditingController();
  TextEditingController gamePlatformController = TextEditingController();
  File? gameImage;
  static String placeHolder =
      'https://external-preview.redd.it/zzgctwJ58xJ6cSerODdCReYJ27-99SoD5RpyFl0Lf1o.png?auto=webp&s=0f04ccc0d9bbfb455cccda349c26ae9e7dc0e4f2';

  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  List<Game>? mobysGames;
  late List<dynamic> savedGames;
  late List<dynamic> savedGamesList;
  bool isLoading = false;
  Box gamesBox = Hive.box('savedGames');

  @override
  void initState() {
    pageController.addListener(() {
      updatePage();
    });
    if (gamesBox.get('savedGames') == null) {
      savedGames = [];
      updateDatabase();
    } else {
      loadDatabase();
    }
    updatedSavedGamesList();
    super.initState();
  }

  void updatePage() {
    setState(() {
      currentPage = pageController.page!.round();
      searchBarController.text = '';
      updatedSavedGamesList();
    });
  }

  void updateDatabase() {
    gamesBox.put('savedGames', savedGames);
  }

  void loadDatabase() {
    savedGames = gamesBox.get('savedGames');
  }

  getData() async {
    print('HE CANT HIDE FOR LONG BOSS');
    setState(() {
      isLoading = true;
    });
    mobysGames = await RemoteService().getGames(searchBarController.text);
    setState(() {
      isLoading = false;
    });
    print('HERE HE IS BOSS');
  }

  void updatedSavedGamesList() {
    if (searchBarController.text.isEmpty) {
      setState(() {
        savedGamesList = savedGames;
      });
    } else {
      setState(() {
        savedGamesList = savedGames.where((game) {
          return game.title
              .toLowerCase()
              .contains(searchBarController.text.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        pageController.animateTo(pageController.position.minScrollExtent,
            duration: const Duration(milliseconds: 400), curve: Curves.linear);
        searchBarController.text = '';
        updatedSavedGamesList();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: Visibility(
          visible: currentPage == 0,
          child: FloatingActionButton.large(
            backgroundColor: interactColor.withOpacity(0.5),
            onPressed: () {
              openDialog(context);
            },
            child: Icon(
              Icons.add,
              size: 80,
              color: interactColor.withOpacity(0.5),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: solidColor,
          title: TextFieldInput(
            // onChange: (p0) => getData(),
            textEditingController: searchBarController,
            hintText: 'Search Here',
            textInputType: TextInputType.name,
            onDone: () {
              pageController.page == 0 ? updatedSavedGamesList() : getData();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundColor: highlightColor,
                child: IconButton(
                  onPressed: () {
                    pageController.page == 0
                        ? updatedSavedGamesList()
                        : getData();
                  },
                  icon: Icon(
                    Icons.search,
                    color: interactColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: PageView(
          controller: pageController,
          children: [
            //Your games
            ListView.builder(
              padding: const EdgeInsets.only(bottom: 150),
              itemCount: savedGamesList.length ?? 0,
              itemBuilder: (context, index) {
                return GameCard(
                    delete: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: highlightColor,
                              title: Column(
                                children: [
                                  Text(
                                    'Do you want to delete',
                                    style: subHeadingTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '${savedGamesList[index].title}?',
                                    style: headingTextStyle,
                                  )
                                ],
                              ),
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MyButton(
                                      color: Colors.red,
                                      text: 'Delete',
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        savedGames
                                            .remove(savedGamesList[index]);
                                        searchBarController.text = '';
                                        updatedSavedGamesList();
                                        updateDatabase();
                                      }),
                                )
                              ],
                            );
                          });
                    },
                    sampleCover: savedGamesList[index].sampleCover,
                    title: savedGamesList[index].title,
                    description: savedGamesList[index].description == null
                        ? 'No description found'
                        : savedGamesList[index].description!,
                    releaseDate: savedGamesList[index]
                        .platforms
                        .map((GamePlatform) => GamePlatform.firstReleaseDate)
                        .first,
                    platforms: savedGames[index]
                        .platforms
                        .map((GamePlatform) => GamePlatform.platformName)
                        .join('  \n'));
              },
            ),
            //moby games
            Container(
              color: highlightColor,
              child: Visibility(
                visible: !isLoading,
                replacement: const Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(color: Colors.blueGrey),
                  ),
                ),
                child: Visibility(
                  visible: mobysGames != null,
                  replacement: Center(
                      child: Text(
                    'No games to display',
                    style: headingTextStyle,
                    textAlign: TextAlign.center,
                  )),
                  child: ListView.builder(
                    itemCount: mobysGames?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GameCard(
                          onGameAddPls: () {
                            print("IT'S WORKING BOSS, YOU DID IT AGAIN!");
                            savedGames.add(Game(
                                title: mobysGames![index].title,
                                description: mobysGames![index].description
                                            is String ||
                                        mobysGames![index].description is List
                                    ? parse(mobysGames![index].description)
                                        .documentElement!
                                        .text
                                    : 'No description found :(',
                                sampleCover:
                                    mobysGames![index].sampleCover == null
                                        ? Sample(
                                            image: placeHolder,
                                            imageType: ImageType.network)
                                        : mobysGames![index].sampleCover!,
                                platforms: mobysGames![index].platforms));
                            updatedSavedGamesList();
                            showSnackBar('Added to games list', context);
                            updateDatabase();
                          },
                          addableCard: true,
                          sampleCover: mobysGames![index].sampleCover == null
                              ? Sample(
                                  image: placeHolder,
                                  imageType: ImageType.network)
                              : mobysGames![index].sampleCover!,
                          title: mobysGames![index].title,
                          description:
                              mobysGames![index].description is String ||
                                      mobysGames![index].description is List
                                  ? parse(mobysGames![index].description)
                                      .documentElement!
                                      .text
                                  : 'No description found :(',
                          // description: mobysGames![index].description,
                          releaseDate: mobysGames![index]
                              .platforms
                              .map((GamePlatform) =>
                                  GamePlatform.firstReleaseDate)
                              .first,
                          platforms: mobysGames![index]
                              .platforms
                              .map((GamePlatform) => GamePlatform.platformName)
                              .join('  \n'));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future openDialog(context) => showDialog(
      context: context,
      builder: (context) {
        String titleText = 'Title';
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: AlertDialog(
                backgroundColor: solidColor,
                titlePadding: EdgeInsets.zero,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                title: Text(
                  titleText,
                  style: headingTextStyle,
                  textAlign: TextAlign.center,
                ),
                content: Column(
                  children: [
                    //cancel button
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          side: MaterialStateProperty.all<BorderSide>(
                              const BorderSide(color: Colors.black, width: 3)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          resetFields();
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: Text(
                          'Cancel',
                          style: subHeadingTextStyle,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(roundBoxRadius),
                          border: Border.all(color: Colors.black, width: 3)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFieldInput(
                            textEditingController: gameTitleController,
                            hintText: 'Game Title',
                            textInputType: TextInputType.name,
                          ),
                          const SizedBox(height: 10),
                          TextFieldInput(
                            textEditingController: gameDescriptionController,
                            hintText: 'Game Description',
                            textInputType: TextInputType.name,
                          ),
                          const SizedBox(height: 10),
                          DateFieldYYY(
                            textEditingController: gameDateController,
                            hintText: 'Enter Date (YYYY)',
                          ),
                          const SizedBox(height: 10),
                          TextFieldInput(
                              textEditingController: gamePlatformController,
                              hintText: 'Enter GamePlatform',
                              textInputType: TextInputType.name),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyButton(
                                width: 80,
                                text: 'Gallery Image',
                                onTap: () async {
                                  await _pickImageFromGallery();
                                  setState(() {});
                                },
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              MyButton(
                                width: 80,
                                text: 'Camera',
                                onTap: () async {
                                  await _pickImageFromCamera();
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          MyButton(
                            text: 'Add Game',
                            onTap: () {
                              bool worked = addGameManually();
                              if (worked == false) {
                                setState(() {
                                  titleText = 'Pls fill in all fields';
                                });
                              }
                            },
                            color: interactColor,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: highlightColor,
                              border:
                                  Border.all(color: backgroundColor, width: 3),
                              borderRadius:
                                  BorderRadius.circular(roundBoxRadius),
                            ),
                            //Image
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: gameImage == null
                                  ? SizedBox(
                                      height: 720 / 5.5,
                                      width: 1042 / 5.5,
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Image.asset(
                                            'assets/images/mario_placeholder.png'),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 720 / 5.5,
                                      width: 1042 / 5.5,
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Image.file(gameImage!),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      });

  bool addGameManually() {
    if (gameTitleController.text.isNotEmpty &&
        gamePlatformController.text.isNotEmpty &&
        gameImage != null) {
      savedGames.add(
        Game(
          title: gameTitleController.text,
          description: gameDescriptionController.text,
          platforms: [
            GamePlatform(
                platformName: gamePlatformController.text,
                firstReleaseDate: gameDateController.text.isEmpty
                    ? DateFormat('yyyy').format(DateTime.now()).toString()
                    : gameDateController.text)
          ],
          sampleCover: Sample(image: gameImage, imageType: ImageType.file),
        ),
      );
      updateDatabase();
      updatedSavedGamesList();
      Navigator.of(context).pop();
      resetFields();
      return true;
    } else {
      return false;
    }
  }

  void resetFields() {
    gameTitleController.text = '';
    gameDescriptionController.text = '';
    gamePlatformController.text = '';
    gameImage = null;
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      gameImage = File(returnedImage.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      gameImage = File(returnedImage.path);
    });
  }
}
