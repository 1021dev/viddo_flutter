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
  accentColor: Color(0xFFFFA685),
  primaryColor: Color(0xFFFFFFFF),
  hintColor: Color(0x998476AB),
  focusColor: Color(0xFF8476AB),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFFFFA685),
    highlightColor: Color(0xFFF6AE5C),
    textTheme: ButtonTextTheme.primary,
  ),
  fontFamily: 'Roboto',
);
