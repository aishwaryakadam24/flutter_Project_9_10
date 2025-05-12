
import 'package:flutter/material.dart';
import 'my_color.dart';

ThemeData appTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: MyColor.lightGreen,
    scaffoldBackgroundColor: MyColor.white,
    appBarTheme: AppBarTheme(
      backgroundColor: MyColor.lightYellow,
      foregroundColor: MyColor.black,
      elevation: 0,
    ),
    colorScheme: ColorScheme.light(
      primary: MyColor.lightGreen,
      secondary: MyColor.lightPink,
      background: MyColor.white,
      surface: MyColor.lightBlue,
      onPrimary: MyColor.black,
      onSecondary: MyColor.black,
      onBackground: MyColor.black,
      onSurface: MyColor.black,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: MyColor.black),
      bodyMedium: TextStyle(color: MyColor.black),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: MyColor.lightGreen,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
