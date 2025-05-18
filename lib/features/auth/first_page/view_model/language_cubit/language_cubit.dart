import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState(selectedLanguage: Locale('en')));

  void changeLanguage(Locale newLanguage) {
    emit(LanguageState(selectedLanguage: newLanguage));
  }
}
