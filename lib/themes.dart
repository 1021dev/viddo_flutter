import 'package:flutter/material.dart';

Color _applePrimary = Color(0xFF87C662);

ThemeData appleTheme = ThemeData(
  primaryColor: _applePrimary,
  buttonColor: _applePrimary,
);

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
    caption: TextStyle(color: Colors.black),
    button: TextStyle(color: Colors.white),
  ),
  textSelectionColor: Color(0xFF000000),
  accentColor: Color(0xFFE66E5C),
  primaryColor: Color(0xFFFFFFFF),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFFE66E5C),
    highlightColor: Color(0xFFF6AE5C),
    textTheme: ButtonTextTheme.primary,
  ),
);
