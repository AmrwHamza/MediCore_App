import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/features/on_boarding/presentation/views/widget/first_page.dart';
import 'package:medicore_app/features/on_boarding/presentation/views/widget/secound_page.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [FirstPage(), SecoundPage()]);
  }
}
