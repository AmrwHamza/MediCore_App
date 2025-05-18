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
          Spacer(),
          Image.asset(
            Assets.logoWithoutBackground,
            width: MediaQuery.of(context).size.width * 0.6,
          ),

          Spacer(flex: 2),
          Text(
            'Your best way to protect your health and your children\'s health',
            textAlign: TextAlign.center,
            style: TextStyles.H1.copyWith(color: KPrimaryColor)
          ),
          Spacer(flex: 5),
        ],
      ),
    );
  }
}
