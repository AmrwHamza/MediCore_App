import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/core/theme/theme.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/core/utils/logger_helper.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/otp_view.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view/first_page_auth.dart';
import 'package:medicore_app/features/main_home/presentation/view/main_home_view.dart';
import 'package:medicore_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/patient_info_view.dart';
import 'package:provider/provider.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _rotationAnimation = Tween<double>(
      begin: -0.05,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    _startSplashSequence();
  }

  Future<void> _startSplashSequence() async {
    await Future.delayed(const Duration(milliseconds: 2300));
    await _checkLogin();
  }

  Future<void> _checkLogin() async {
    final token = await SharedPrefHelper.getString(SharedPrefKeys.userToken);
    final isLoggedIn = token != null && token.isNotEmpty;
    // context.go(PatientInfoView.routeName);

    isLoggedIn
        ? LoggerHelper.success('user token: $token')
        : LoggerHelper.error('No Token');
    if (isLoggedIn) {
      context.go(MainHomeView.routeName);
    } else {
      context.go(OnBoardingView.routeName);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;

    return Scaffold(
      backgroundColor: theme.splashColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform(
                alignment: Alignment.center,
                transform:
                    Matrix4.identity()
                      ..scale(_scaleAnimation.value)
                      ..rotateZ(_rotationAnimation.value),
                child: SvgPicture.asset(
                  theme == lightMode
                      ? Assets.imagesStethoscopeLightMode
                      : Assets.imagesStethoscopeDarkMode,
                  width: 180,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
