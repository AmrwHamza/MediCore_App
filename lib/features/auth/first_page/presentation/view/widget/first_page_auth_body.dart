import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view/widget/auth_section.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view/widget/drop_down.dart';

class FirstPageAuthBody extends StatelessWidget {
  const FirstPageAuthBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Image.asset(Assets.imagesBackgroundAuth, fit: BoxFit.fill),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'title of auth'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyles.H1.copyWith(
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                const DropDown(),
                const SizedBox(height: 70),
                const AuthSection(),
                // const SizedBox(height: 100),
                // CustomDivider(title: 'or'.tr()),
                // const SizedBox(height: 16),
                // LoginWithID(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
