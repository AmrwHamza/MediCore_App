import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/utils/app_images.dart';

class SecoundPage extends StatelessWidget {
  const SecoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Spacer(),
          Image.asset(
            Assets.imagesLogoWithoutBackground,
            width: MediaQuery.of(context).size.width * 0.6,
          ),

          const Spacer(flex: 2),
          Text(
            'secound page title in onBoarding',
            textAlign: TextAlign.center,
            style: TextStyles.H1.copyWith(color: KPrimaryColor),
          ).tr(),
          const Spacer(flex: 5),
        ],
      ),
    );
  }
}
