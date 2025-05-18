import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/core/widget/custom_divider.dart';
import 'package:medicore_app/features/auth/first_page/view/widget/auth_section.dart';
import 'package:medicore_app/features/auth/first_page/view/widget/drop_down.dart';
import 'package:medicore_app/features/auth/first_page/view/widget/login_with_id.dart';

class FirstPageAuthBody extends StatelessWidget {
  const FirstPageAuthBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Image.asset(Assets.backgroundAuth, fit: BoxFit.fill),
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
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Your health journey starts right here',
                    textAlign: TextAlign.center,
                    style: TextStyles.H1.copyWith(
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                DropDown(),
                const SizedBox(height: 70),
                AuthSection(),
                const SizedBox(height: 100),
                CustomDivider(title: 'OR'),
                const SizedBox(height: 16),
                LoginWithID(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
