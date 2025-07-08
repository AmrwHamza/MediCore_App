import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view/create_account.dart';
import 'package:medicore_app/features/auth/login/presentation/view/login_view.dart';

class AuthSection extends StatelessWidget {
  const AuthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          title: 'create account'.tr(),
          onTap: () {
            context.pushNamed(CreateAccount.routeName);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'have account',
              style: TextStyles.public.copyWith(color: Colors.white),
            ).tr(),
            TextButton(
              onPressed: () {
                context.pushNamed(LoginView.routeName);
              },
              child:
                  Text(
                    'login',
                    style: TextStyles.public.copyWith(color: KCyan),
                  ).tr(),
            ),
          ],
        ),
        context.locale.languageCode == 'ar'
            ? const SizedBox(height: 10)
            : const SizedBox(height: 1),
      ],
    );
  }
}
