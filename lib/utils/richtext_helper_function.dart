import 'package:flutter/material.dart';

RichText styledRichText(
    String staticText, dynamic dynamicText, Color paletteColor,
    {double? fontSize = 18}) {
  String formattedDynamicText;

  if (dynamicText is List) {
    formattedDynamicText = dynamicText.join(", ");
  } else if (dynamicText is int || dynamicText is double) {
    formattedDynamicText = dynamicText.toString();
  } else {
    formattedDynamicText = dynamicText;
  }

  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: staticText,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Pokemon',
            fontSize: fontSize,
            letterSpacing: 1.75,
          ),
        ),
        TextSpan(
          text: formattedDynamicText,
          style: TextStyle(
            color: paletteColor,
            fontFamily: 'Pokemon',
            fontSize: fontSize,
            letterSpacing: 1.75,
          ),
        ),
      ],
    ),
  );
}
