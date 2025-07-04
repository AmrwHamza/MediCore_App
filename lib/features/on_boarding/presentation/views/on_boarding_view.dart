import 'package:flutter/material.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/on_boarding/presentation/views/widget/on_boarding_view_body.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  static const routeName = '/OnBoarding';

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getIt<ThemeProvider>().themeData.scaffoldBackgroundColor,
      body: const SafeArea(child: OnBoardingViewBody()),
    );
  }
}
