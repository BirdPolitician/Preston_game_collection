import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:preston_game_collection/models/image_type.dart';
import 'package:preston_game_collection/models/sample_model.dart';
import 'package:preston_game_collection/utils/global_variables.dart';
import 'package:expandable/expandable.dart';

class GameCard extends StatelessWidget {
  final bool addableCard;
  final String title;
  final String description;
  final String releaseDate;
  final Sample? sampleCover;
  final String platforms;
  final Function? onGameAddPls;
  final Function? delete;

  const GameCard({
    super.key,
    this.addableCard = false,
    this.onGameAddPls,
    this.delete,
    required this.title,
    required this.description,
    required this.releaseDate,
    required this.sampleCover,
    required this.platforms,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(roundBoxRadius),
          color: solidColor,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 8),
          child: ExpandablePanel(
            theme: const ExpandableThemeData(
              tapHeaderToExpand: true,
              hasIcon: false,
            ),
            header: Column(
              children: [
                addableCard
                    ? SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(interactColor),
                          ),
                          onPressed: () {
                            onGameAddPls!();
                          },
                          child: Text(
                            'Add Game To Collection',
                            style: subHeadingTextStyle,
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: highlightColor,
                        border: Border.all(color: backgroundColor, width: 3),
                        borderRadius: BorderRadius.circular(roundBoxRadius),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SizedBox(
                          height: 1040 / 9.5,
                          width: 720 / 9.5,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: sampleCover == null
                                ? Image.asset(
                                    'assets/images/mario_placeholder.png')
                                : sampleCover!.imageType == ImageType.file
                                    ? Image.file(sampleCover!.image!)
                                    : Image.network(sampleCover!.image!),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        title,
                        style: subHeadingTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            expanded: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: ExpandableText(
                          platforms,
                          style: subHeadingTextStyle,
                          expandText: '',
                          maxLines: 1,
                          expandOnTextTap: true,
                          collapseOnTextTap: true,
                          linkColor: interactColor,
                        ),
                      ),
                      AutoSizeText(
                        DateFormat('yyyy').parse(releaseDate).year.toString(),
                        style: subHeadingTextStyle,
                      )
                    ],
                  ),
                ),
                ExpandableText(
                  description,
                  expandText: '',
                  collapseText: '',
                  linkColor: interactColor,
                  collapseOnTextTap: true,
                  expandOnTextTap: true,
                  style: bodyTextStyle,
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 10,
                ),
                delete == null
                    ? Container()
                    : SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                            ),
                            onPressed: () {
                              delete!();
                            },
                            child: Text(
                              'Delete this Game?',
                              style: subHeadingTextStyle,
                            )),
                      )
              ],
            ),
            collapsed: Container(),
          ),
        ),
      ),
    );
  }
}
