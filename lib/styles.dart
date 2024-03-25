import 'package:flutter/material.dart';

// Vibrant Color Palette
const Color primaryColor = Color(0xFF6C63FF); // A bright and lively purple
const Color secondaryColor =
    Color(0xFFFAFAFA); // A soft off-white for backgrounds
const Color backgroundColor =
    Color.fromARGB(255, 182, 179, 242); // A vivid pink for accents
const Color buttonColor =
    Color(0xFF32E0C4); // A refreshing mint green for buttons
const Color errorColor = Color(0xFFE63946); // A striking red for error messages

// AppBar Style
const appBarTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 24,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.2,
);

// Error Text Style
const errorTextStyle = TextStyle(
  color: errorColor,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

// Button Style
final buttonStyle = ElevatedButton.styleFrom(
  primary: buttonColor,
  onPrimary: Colors.white,
  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
  textStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  ),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  elevation: 5,
  shadowColor: buttonColor.withOpacity(0.4),
);

// Title Text Style
const titleTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 22,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.1,
);

// Subtitle Text Style
const subtitlePaleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
);

// Input decoration
InputDecoration inputDecoration({String? hintText}) {
  return InputDecoration(
    fillColor: Colors.white,
    filled: true,
    hintText: hintText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide.none,
    ),
  );
}
