import 'package:flutter/material.dart';

Color _applePrimary = Color(0xFF87C662);

ThemeData appleTheme = ThemeData(
  primaryColor: _applePrimary,
  buttonColor: _applePrimary,
);

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
    caption: TextStyle(color: Color(0xFF343434)),
    button: TextStyle(color: Colors.white),
  ),
  textSelectionColor: Color(0xFF0F77A1),
  accentColor: Color(0xFF0F77A1),
  primaryColor: Color(0xFF0F77A1),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF227BAB),
    highlightColor: Color(0xFF64A2D0),
    textTheme: ButtonTextTheme.primary,
  ),
);
