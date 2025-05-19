import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/utils/app_images.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(flex: 1),
        Text(
          'first page title in onBoarding'.tr(),
          style: TextStyles.H1.copyWith(color: KPrimaryColor),
        ),
        Spacer(flex: 4),
        Expanded(flex: 50, child: SvgPicture.asset(Assets.doctors)),
      ],
    );
  }
}
