part of 'change_language_cubit.dart';

abstract class ChangeLanguageState extends Equatable {
  final Locale language;
  const ChangeLanguageState(this.language);

  @override
  List<Object> get props => [language];
}

class ChangeLanguageInitial extends ChangeLanguageState {
  const ChangeLanguageInitial(Locale language) : super(language);
}

class ChangeLanguageSuccess extends ChangeLanguageState {
  const ChangeLanguageSuccess(Locale language) : super(language);
}
