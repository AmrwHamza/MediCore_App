import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/utils/logger_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static final SharedPrefHelper _instance = SharedPrefHelper._internal();

  factory SharedPrefHelper() {
    return _instance;
  }

  SharedPrefHelper._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // === Theme ===
  Future<void> setDarkMode(bool isDark) async {
    await _prefs?.setBool(SharedPrefKeys.isDarkTheme, isDark);
  }

  bool get isDarkMode => _prefs?.getBool(SharedPrefKeys.isDarkTheme) ?? false;

  // === Language ===
  Future<void> setLanguageCode(String code) async {
    await _prefs?.setString(SharedPrefKeys.language, code);
  }

  String get languageCode => _prefs?.getString(SharedPrefKeys.language) ?? 'en';

  // === Auth Token ===
  Future<void> setAuthToken(String token) async {
    await _prefs?.setString(SharedPrefKeys.userToken, token);
  }

  String? get authToken => _prefs?.getString(SharedPrefKeys.userToken);

  Future<void> clearToken() async {
    await _prefs?.remove(SharedPrefKeys.userToken);
  }

  Future<void> clearAll() async {
    await _prefs?.clear();
  }

  static getString(String key) async {
    try {
      debugPrint('SharedPrefHelper : getString with key : $key');
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      return sharedPreferences.getString(key) ?? '';
    } on Exception catch (e) {
      debugPrint('=================Error while get string:======= $e');
    }
  }

  static setData(String key, value) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      debugPrint(
        "SharedPrefHelper : setData with key : $key and value : $value",
      );
      switch (value.runtimeType) {
        case String:
          await sharedPreferences.setString(key, value);
          break;
        case int:
          await sharedPreferences.setInt(key, value);
          break;
        case bool:
          await sharedPreferences.setBool(key, value);
          break;
        case double:
          await sharedPreferences.setDouble(key, value);
          break;
        default:
          return throw Exception(
            "==||==Unsupported value type:==||== ${value.runtimeType}",
          );
      }
    } on Exception catch (e) {
      debugPrint('=================Error while setting data:======= $e');
    }
  }

  static removeData(String key) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.remove(key);
    } on Exception catch (e) {
      LoggerHelper.error(e.toString());
    }
  }
}
