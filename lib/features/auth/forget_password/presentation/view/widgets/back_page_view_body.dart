import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view/first_page_auth.dart';

class BackPageViewBody extends StatelessWidget {
  const BackPageViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.imagesResetPassword, height: 200),
          const SizedBox(height: 32),
          Text(
            'email_sent_title'.tr(),
            style: TextStyles.H1.copyWith(
              color: context.watch<ThemeProvider>().themeData.canvasColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'email_sent_description'.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          CustomButton(
            title: 'back_to_login'.tr(),
            onTap: () {
              context.go(FirstPageAuth.routeName);
            },
          ),
        ],
      ),
    );
  }
}
