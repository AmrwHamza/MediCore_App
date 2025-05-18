import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class LanguageState extends Equatable {
  final Locale selectedLanguage;

  const LanguageState({required this.selectedLanguage});

  @override
  List<Object?> get props => [selectedLanguage];
}
