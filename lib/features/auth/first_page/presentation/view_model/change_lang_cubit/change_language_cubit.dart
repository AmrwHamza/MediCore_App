import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';

part 'change_language_state.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  final SharedPrefsManager prefs;

  ChangeLanguageCubit(this.prefs)
      : super(ChangeLanguageInitial(Locale(prefs.languageCode)));

  void changeLanguage(Locale locale) async {
    await prefs.setLanguageCode(locale.languageCode);
    emit(ChangeLanguageSuccess(locale));
  }
}
