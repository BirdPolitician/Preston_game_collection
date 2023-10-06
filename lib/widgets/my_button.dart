import 'package:flutter/material.dart';
import 'package:preston_game_collection/utils/global_variables.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final double height;
  final double width;
  final Color color;

  const MyButton({
    required this.text,
    required this.onTap,
    this.color = const Color(0xFF02640C),
    this.height = 90,
    this.width = 160,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: interactColor, width: 3),
          borderRadius: BorderRadius.circular(roundBoxRadius),
        ),
        child: Center(
          child: Text(
            text,
            style: subHeadingTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
