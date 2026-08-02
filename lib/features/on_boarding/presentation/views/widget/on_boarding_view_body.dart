import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view/first_page_auth.dart';
import 'package:medicore_app/features/on_boarding/presentation/views/widget/on_boarding_page_view.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;
  double currentPage = 0;

  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      final nextPage = pageController.page!.round().toDouble();
      if (currentPage != nextPage) {
        setState(() {
          currentPage = nextPage;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark =
        context.watch<ThemeProvider>().themeData.brightness == Brightness.dark;
    final primaryColor = isDark ? KPrimaryColor : KPrimaryDark;

    return Stack(
      children: [
        Positioned(
          top: -size.height * 0.15,
          right: -size.width * 0.2,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            width: size.width * 0.8,
            height: size.width * 0.8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  currentPage == 0
                      ? primaryColor.withValues(alpha: isDark ? 0.15 : 0.2)
                      : Colors.purple.withValues(alpha: isDark ? 0.15 : 0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -size.height * 0.1,
          left: -size.width * 0.2,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            width: size.width * 0.7,
            height: size.width * 0.7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  currentPage == 0
                      ? Colors.teal.withValues(alpha: isDark ? 0.1 : 0.15)
                      : Colors.purple.withValues(alpha: isDark ? 0.15 : 0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: currentPage == 0 ? 1.0 : 0.0,
                        child: IgnorePointer(
                          ignoring: currentPage != 0,
                          child: TextButton(
                            onPressed:
                                () => context.go(FirstPageAuth.routeName),
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  isDark
                                      ? Colors.white10
                                      : Colors.black.withValues(alpha: 0.04),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 8,
                              ),
                            ),
                            child:
                                Text(
                                  'skip'.tr(),
                                  style: TextStyles.public.copyWith(
                                    color:
                                        isDark
                                            ? Colors.white70
                                            : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ).tr(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: OnBoardingPageView(pageController: pageController),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DotsIndicator(
                        dotsCount: 2,
                        position: currentPage,
                        decorator: DotsDecorator(
                          activeColor:
                              currentPage == 0
                                  ? primaryColor
                                  : Colors.purple.shade400,
                          color: isDark ? Colors.white24 : Colors.black12,
                          size: const Size(8.0, 8.0),
                          activeSize: const Size(24.0, 8.0),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: currentPage == 0 ? 64 : 160,
                        height: 64,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: AlignmentGeometry.topLeft,
                            end: AlignmentGeometry.bottomRight,
                            colors:
                                currentPage == 0
                                    ? [primaryColor, KCyan]
                                    : [KPrimaryColor, Colors.purple.shade400],
                          ),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: 0.4),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if (currentPage == 0) {
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOutCubic,
                                );
                              } else {
                                context.go(FirstPageAuth.routeName);
                              }
                            },
                            borderRadius: BorderRadius.circular(50),
                            child: Center(
                              child: AnimatedCrossFade(
                                duration: const Duration(milliseconds: 250),
                                crossFadeState:
                                    currentPage == 0
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                firstChild: const SizedBox(
                                  width: 64,
                                  height: 64,
                                  child: Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                                secondChild: SizedBox(
                                  width: 160,
                                  height: 64,
                                  child: Center(
                                    child: Text(
                                      'get_started'.tr(),
                                      style: TextStyles.public.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
