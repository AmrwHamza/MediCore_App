import 'package:flutter/material.dart';
import 'package:medicore_app/features/on_boarding/presentation/views/widget/on_boarding_view_body.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});
  static const routeName = '/OnBoarding';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const OnBoardingViewBody());
  }
}
