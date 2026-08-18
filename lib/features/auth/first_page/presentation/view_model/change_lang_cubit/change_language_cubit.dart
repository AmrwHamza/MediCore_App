import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';

part 'change_language_state.dart';

/// Single source of truth for switching the app language at runtime.
///
/// Switching a language must:
/// 1. persist the new locale (SharedPreferences),
/// 2. update the in-memory locale state,
/// 3. notify EasyLocalization so every localized widget rebuilds immediately
///    (no app restart / rebuild required) and RTL/LTR updates accordingly.
class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  final SharedPrefHelper prefs;

  ChangeLanguageCubit(this.prefs)
    : super(ChangeLanguageInitial(Locale(prefs.languageCode)));

  Future<void> changeLanguage(BuildContext context, Locale locale) async {
    if (locale.languageCode == state.language.languageCode) return;

    await prefs.setLanguageCode(locale.languageCode);
    emit(ChangeLanguageSuccess(locale));
    await context.setLocale(locale);
  }
}