import 'package:flutter/material.dart';
import 'package:medicore_app/core/utils/logger_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/profile/domain/entities/edit_profile_entity.dart';
import '../../features/profile/domain/entities/patient_profile_entity.dart';

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

  EditProfileEntity get profileInfo {
    return EditProfileEntity(
      firstName: _prefs?.getString(SharedPrefKeys.firstName) ?? '',
      lastName: _prefs?.getString(SharedPrefKeys.lastName) ?? '',
      email: _prefs?.getString(SharedPrefKeys.email) ?? '',
      phone: _prefs?.getString(SharedPrefKeys.phone) ?? '',
    );
  }

  PatientProfileEntity get patientProfileInfo {
    return PatientProfileEntity(
      birthDate: _prefs?.getString(SharedPrefKeys.birthDate) ?? '',
      gender: _prefs?.getString(SharedPrefKeys.gender) ?? '',
      age: _prefs?.getInt(SharedPrefKeys.age) ?? 0,
      bloodType: _prefs?.getString(SharedPrefKeys.bloodType) ?? '',
      medicationAllergies:
          _prefs?.getString(SharedPrefKeys.medicationAllergies) ?? '',
      chronicDiseases: _prefs?.getString(SharedPrefKeys.chronicDiseases) ?? '',
      permanentMedications:
          _prefs?.getString(SharedPrefKeys.permanentMedications) ?? '',
      previousSurgeries:
          _prefs?.getString(SharedPrefKeys.previousSurgeries) ?? '',
      previousIllnesses:
          _prefs?.getString(SharedPrefKeys.previousIllnesses) ?? '',
    );
  }

  Future<void> setProfileInfo({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) async {
    if (firstName != null && firstName.isNotEmpty)
      await _prefs?.setString(SharedPrefKeys.firstName, firstName);
    if (lastName != null && lastName.isNotEmpty)
      await _prefs?.setString(SharedPrefKeys.lastName, lastName);
    if (email != null && email.isNotEmpty)
      await _prefs?.setString(SharedPrefKeys.email, email);
    if (phone != null && phone.isNotEmpty)
      await _prefs?.setString(SharedPrefKeys.phone, phone);
  }

  Future<void> setPatientProfileInfo({
    String? birthDate,
    String? gender,
    int? age,
    String? bloodType,
    String? medicationAllergies,
    String? chronicDiseases,
    String? permanentMedications,
    String? previousSurgeries,
    String? previousIllnesses,
  }) async {
    if (birthDate != null && birthDate.isNotEmpty)
      await _prefs?.setString(SharedPrefKeys.birthDate, birthDate);
    if (gender != null && gender.isNotEmpty)
      await _prefs?.setString(SharedPrefKeys.gender, gender);
    if (age != null) await _prefs?.setInt(SharedPrefKeys.age, age);
    if (bloodType != null && bloodType.isNotEmpty)
      await _prefs?.setString(SharedPrefKeys.bloodType, bloodType);
    if (medicationAllergies != null && medicationAllergies.isNotEmpty)
      await _prefs?.setString(
        SharedPrefKeys.medicationAllergies,
        medicationAllergies,
      );
    if (chronicDiseases != null && chronicDiseases.isNotEmpty)
      await _prefs?.setString(SharedPrefKeys.chronicDiseases, chronicDiseases);
    if (permanentMedications != null && permanentMedications.isNotEmpty)
      await _prefs?.setString(
        SharedPrefKeys.permanentMedications,
        permanentMedications,
      );
    if (previousSurgeries != null && previousSurgeries.isNotEmpty)
      await _prefs?.setString(
        SharedPrefKeys.previousSurgeries,
        previousSurgeries,
      );
    if (previousIllnesses != null && previousIllnesses.isNotEmpty)
      await _prefs?.setString(
        SharedPrefKeys.previousIllnesses,
        previousIllnesses,
      );
  }

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

class SharedPrefKeys {
  static const String userToken = 'userToken';
  static const String firstName = 'firstname';
  static const String lastName = 'lastname';
  static const String email = 'email';
  static const String phone = 'phone';
  static const String expireToken = 'expireToken';
  static const String id = 'id';
  static const String isDarkTheme = 'isDarkTheme';
  static const String language = 'language';
  static const String birthDate = 'birthDate';
  static const String gender = 'gender';
  static const String age = 'age';
  static const String bloodType = 'bloodType';
  static const String medicationAllergies = 'medicationAllergies';
  static const String chronicDiseases = 'chronicDiseases';
  static const String permanentMedications = 'permanentMedications';
  static const String previousSurgeries = 'previousSurgeries';
  static const String previousIllnesses = 'previousIllnesses';
}
