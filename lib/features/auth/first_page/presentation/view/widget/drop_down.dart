import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view_model/change_lang_cubit/change_language_cubit.dart';
import 'package:provider/provider.dart';

class DropDown extends StatelessWidget {
  const DropDown({super.key});

  @override
  Widget build(BuildContext context) {
    final languages = [
      {'locale': const Locale('en'), 'label': 'English', 'fontFamily': null},
      {
        'locale': const Locale('ar'),
        'label': 'العربية',
        'fontFamily': 'Tajawal',
      },
    ];

    return BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: getIt<ThemeProvider>().themeData.shadowColor,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Locale>(
              value: state.language,
              dropdownColor: Colors.white,
              style: TextStyles.public.copyWith(color: Colors.black),
              elevation: 8,
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 35,
                color: Colors.black,
              ),
              items:
                  languages.map((lang) {
                    return DropdownMenuItem<Locale>(
                      value: lang['locale'] as Locale,
                      child: Text(
                        lang['label'] as String,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: lang['fontFamily'] as String?,
                        ),
                      ),
                    );
                  }).toList(),
              onChanged: (newLanguage) {
                if (newLanguage != null) {
                  context.read<ChangeLanguageCubit>().changeLanguage(
                    newLanguage,
                  );
                  context.setLocale(newLanguage);
                  
                }
              },
              selectedItemBuilder: (context) {
                return languages.map((lang) {
                  return Row(
                    children: [
                      const Icon(Icons.language, color: KDarkBlue),
                      const SizedBox(width: 8),
                      Text(
                        lang['label'] as String,
                        style: TextStyles.public.copyWith(color: Colors.black),
                      ),
                    ],
                  );
                }).toList();
              },
            ),
          ),
        );
      },
    );
  }
}
