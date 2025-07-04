import 'package:flutter/material.dart';
import 'package:medicore_app/features/on_boarding/presentation/views/widget/first_page.dart';
import 'package:medicore_app/features/on_boarding/presentation/views/widget/secound_page.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [const FirstPage(), const SecoundPage()],
    );
  }
}
