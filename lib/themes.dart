
import 'package:flutter/material.dart';

Color _appPrimary = Color(0xFFFFA685);

ThemeData appleTheme = ThemeData(
  primaryColor: _appPrimary,
  buttonColor: _appPrimary,
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

class AppColor {
  static Color red = Color(0xFFEB5757);
  static Color orange = Color(0xFFFF9F0A);
  static Color yellow = Color(0xFFFFD60A);
  static Color green = Color(0xFF32D74B);
  static Color sky = Color(0xFF64D2FF);
  static Color blue = Color(0xFF0A84FF);
  static Color purple = Color(0xFF5E5CE6);
  static Color pink = Color(0xFFBF5AF2);
  static Color extraDarkGray = Color(0xFF333333);
  static Color darkGray = Color(0xFF8E8E93);
  static Color gray = Color(0xFFAEAEB2);
  static Color lightGray = Color(0xFFC7C7CC);
  static Color extraLightGray = Color(0xFFE5E5EA);
  static Color white = Color(0xFFFFFFFF);
  static Color borderColor = Color(0x4DFFA685);

  List<Color> colors = [
    red,
    orange,
    yellow,
    green,
    sky,
    blue,
    purple,
    pink,
    extraDarkGray,
    darkGray,
    gray,
    lightGray,
    extraLightGray,
    white,
  ];
}
