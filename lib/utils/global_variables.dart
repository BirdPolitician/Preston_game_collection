import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double roundBoxRadius = 8;

Color backgroundColor = const Color(0xFF000000);
Color solidColor = const Color(0xFF5D5D5D);
Color interactColor = const Color(0xFF04C417);
Color highlightColor = const Color(0xFF02640C);
Color textColor = const Color(0xFFE9E5F3);
Color deleteColor = const Color(0xFFC70000);

TextStyle headingTextStyle = GoogleFonts.oswald(
    fontWeight: FontWeight.bold, fontSize: 30, color: textColor);
TextStyle subHeadingTextStyle = GoogleFonts.oswald(
    fontWeight: FontWeight.bold, fontSize: 22, color: textColor);
TextStyle subHeadingTextStyleUnderlined = GoogleFonts.oswald(
  fontWeight: FontWeight.bold,
  fontSize: 22,
  color: textColor,
  decoration: TextDecoration.underline,
);
TextStyle bodyTextStyle = GoogleFonts.oswald(
    fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black);

sizeableHeadingTextStyle<TextStyle>(fontSize) {
  fontSize = fontSize.toDouble();
  return GoogleFonts.oswald(
      fontWeight: FontWeight.bold, fontSize: fontSize, color: textColor);
}

AssetImage defaultImage = const AssetImage('assets/images/default_image.png');

String defaultImageString = 'assets/images/default_image.png';

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 900),
      content: Text(
        content,
        style: subHeadingTextStyle,
      ),
    ),
  );
}
