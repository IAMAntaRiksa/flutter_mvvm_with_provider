import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/gen/fonts.gen.dart';

import 'package:flutter_caffe_ku/ui/constant/constant.dart';

bool isDarkTheme(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

final lightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: primaryColor,
  primarySwatch: primaryCustomSwatch,
  brightness: Brightness.light,
  fontFamily: FontFamily.poppins,
  bottomSheetTheme:
      BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
  scaffoldBackgroundColor: Colors.white,
  // backgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodySmall: TextStyle(),
    bodyMedium: TextStyle(),
  ).apply(
    bodyColor: blackColor,
    displayColor: blackColor,
  ),
  colorScheme: const ColorScheme.light()
      .copyWith(primary: primaryColor, onPrimary: primaryColor)
      .copyWith(
          primary: primaryColor,
          secondary: primaryColor,
          brightness: Brightness.light),
  textSelectionTheme: TextSelectionThemeData(cursorColor: primaryColor),
);

final darkTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: blackGrayColor,
  primarySwatch: primaryCustomSwatchDark,
  // backgroundColor: blackBGColor,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.white,
  ),
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    bodySmall: TextStyle(),
    bodyMedium: TextStyle(),
  ).apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  fontFamily: FontFamily.poppins,
  bottomSheetTheme:
      BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
  scaffoldBackgroundColor: blackBGColor,
  colorScheme: const ColorScheme.dark()
      .copyWith(primary: blackGrayColor, onPrimary: blackGrayColor)
      .copyWith(
        secondary: blackGrayColor,
        brightness: Brightness.dark,
      ),
  textSelectionTheme: TextSelectionThemeData(cursorColor: blackGrayColor),
);
