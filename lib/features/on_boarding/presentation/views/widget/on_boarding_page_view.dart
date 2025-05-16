import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicore_app/core/utils/app_images.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [Text('Welcome'), SvgPicture.asset(Assets.doctors)],
    );
  }
}
