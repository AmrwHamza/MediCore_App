import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,

  primaryColor: Colors.white,

  canvasColor: Colors.black,

  primaryColorLight: KWhite,
  scaffoldBackgroundColor: KBackgroundLight,
  cardColor: Colors.white,
  shadowColor: Colors.black.withAlpha((255 * 0.3).round()),
  splashColor: KPrimaryColor,
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,

  primaryColor: KAppBarDark,

  canvasColor: Colors.white,

  primaryColorLight: KBackgroundDark,
  scaffoldBackgroundColor: KBackgroundDark,
  cardColor: KCardDark,
  shadowColor: Colors.white.withAlpha((255 * 0.2).round()),
  splashColor: KDarkBlue,
);
