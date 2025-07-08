import 'package:flutter/material.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/core/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  final pref = SharedPrefHelper();
  late ThemeData _themeData = pref.isDarkMode ? darkMode : lightMode;

  ThemeData get themeData => _themeData;

  Future<void> init() async {
    final isDark = await SharedPrefHelper().isDarkMode;
    _themeData = isDark ? darkMode : lightMode;
    notifyListeners();
  }

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void changeTheme() async {
    if (_themeData == lightMode) {
      themeData = darkMode;
      await pref.setDarkMode(true);
    } else {
      themeData = lightMode;
      await pref.setDarkMode(false);
    }
  }
}
