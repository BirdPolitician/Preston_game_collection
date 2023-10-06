import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preston_game_collection/utils/global_variables.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Function(String)? onChange;
  final Function? onDone;

  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    this.onChange,
    this.onDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      style: subHeadingTextStyle,
      controller: textEditingController,
      decoration: InputDecoration(
        hintStyle: GoogleFonts.oswald(
            fontWeight: FontWeight.w600, fontSize: 20, color: textColor),
        hintText: hintText,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: textColor, width: 1)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: interactColor,
            width: 3.0, // adjust for chunkiness
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: interactColor,
            width: 3.0, // adjust for chunkiness
          ),
        ),
        filled: true,
        fillColor: highlightColor,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
      onChanged: onChange,
      textInputAction: TextInputAction.done,
      onSubmitted: (String value) {
        onDone == null ? null : onDone!();
      },
    );
  }
}

class TextFieldInputSecondStyle extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInputSecondStyle({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UnderlineInputBorder underLineInputBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: interactColor, width: 3));
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: TextField(
        style: subHeadingTextStyle,
        controller: textEditingController,
        decoration: InputDecoration(
          hintStyle: GoogleFonts.oswald(
              fontWeight: FontWeight.w600, fontSize: 20, color: textColor),
          hintText: hintText,
          border: underLineInputBorder,
          focusedBorder: underLineInputBorder,
          enabledBorder: underLineInputBorder,
          contentPadding: const EdgeInsets.only(
              bottom: 0), // Adjust this value to get desired spacing.
        ),
        keyboardType: textInputType,
        obscureText: isPass,
      ),
    );
  }
}

class MultiLineTextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  const MultiLineTextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      expands: true,
      maxLines: null,
      textAlignVertical: TextAlignVertical.top,
      style: subHeadingTextStyle,
      controller: textEditingController,
      decoration: InputDecoration(
        hintStyle: GoogleFonts.oswald(
            fontWeight: FontWeight.w600, fontSize: 20, color: textColor),
        hintText: hintText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(roundBoxRadius),
            borderSide: BorderSide(color: textColor, width: 1)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(roundBoxRadius),
          borderSide: BorderSide(
            color: interactColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(roundBoxRadius),
          borderSide: BorderSide(
            color: interactColor,
          ),
        ),
        filled: true,
        fillColor: interactColor,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: TextInputType.multiline,
      obscureText: isPass,
    );
  }
}

class DateFieldYYY extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final Function(String)? onChange;

  const DateFieldYYY({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    this.onChange,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      style: subHeadingTextStyle,
      controller: textEditingController,
      decoration: InputDecoration(
        hintStyle: GoogleFonts.oswald(
            fontWeight: FontWeight.w600, fontSize: 20, color: textColor),
        hintText: hintText,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: textColor, width: 1)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: interactColor,
            width: 3.0, // adjust for chunkiness
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: interactColor,
            width: 3.0, // adjust for chunkiness
          ),
        ),
        filled: true,
        fillColor: highlightColor,
        contentPadding: const EdgeInsets.all(8),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'[0-9]')), // Allows only numbers
        LengthLimitingTextInputFormatter(4), // Limits the length to 4 digits
      ],
      keyboardType: TextInputType.number,
      obscureText: isPass,
      onChanged: onChange,
    );
  }
}
