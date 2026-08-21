import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';

part 'change_language_state.dart';

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