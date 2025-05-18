import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/features/auth/first_page/view_model/language_cubit/language_cubit.dart';
import 'package:medicore_app/features/auth/first_page/view_model/language_cubit/language_state.dart';

class DropDown extends StatelessWidget {
  const DropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Locale>(
              value: state.selectedLanguage,
              dropdownColor: Colors.white,
              style:  TextStyles.public.copyWith(color: Colors.black),
              isExpanded: false,
              elevation: 8,
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 35,
                color: Colors.black,
              ),
              items:  [
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('English', style: TextStyles.public.copyWith(color: Colors.black),),
                ),
                DropdownMenuItem(
                  value: Locale('ar'),
                  child: Text(
                    'العربية',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Tajawal",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
              onChanged: (newLocale) {
                if (newLocale != null) {
                  context.read<LanguageCubit>().changeLanguage(newLocale);
                }
              },
              selectedItemBuilder: (BuildContext context) {
                return  [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.language, color: KDarkBlue),
                      SizedBox(width: 8),
                      Text('English', style: TextStyles.public.copyWith(color: Colors.black),),
                      SizedBox(width: 8),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.language, color: KDarkBlue),
                      SizedBox(width: 25),
                      Text('العربية', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ];
              },
            ),
          ),
        );
      },
    );
  }
}
