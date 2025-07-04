import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  // for app bar
  primaryColor: Colors.white,
  // for text
  canvasColor: Colors.black,
  //secound color of background
  primaryColorLight: KWhite,
  scaffoldBackgroundColor: KBackgroundLight,
  cardColor: Colors.white,
  shadowColor: Colors.black.withAlpha((255 * 0.3).round()),
  splashColor: KPrimaryColor,
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  // for app bar
  primaryColor: KAppBarDark,
  // for text
  canvasColor: Colors.white,
  //secound color of background
  primaryColorLight: KBackgroundDark,
  scaffoldBackgroundColor: KBackgroundDark,
  cardColor: KCardDark,
  shadowColor: Colors.white.withAlpha((255 * 0.2).round()),
  splashColor: KDarkBlue,
);
