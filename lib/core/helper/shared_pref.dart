import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicore_app/constants.dart';

class SharedPrefsManager {
  static final SharedPrefsManager _instance = SharedPrefsManager._internal();

  factory SharedPrefsManager() {
    return _instance;
  }

  SharedPrefsManager._internal();

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
}
