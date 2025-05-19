import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/features/auth/first_page/view/first_page_auth.dart';
import 'package:medicore_app/features/on_boarding/presentation/views/widget/on_boarding_page_view.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;
  var currentPage = 0;

  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      currentPage = pageController.page!.round();
      setState(() {});
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
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          Visibility(
            visible: currentPage == 0 ? true : false,
            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      FirstPageAuth.routeName,
                      (route) => false,
                    );
                  },
                  child: Text(
                    'skip',
                    style: TextStyles.public.copyWith(color: KGrey)
                  ).tr(),
                ),
              ],
            ),
          ),
          Expanded(child: OnBoardingPageView(pageController: pageController)),
          DotsIndicator(
            dotsCount: 2,
            decorator: DotsDecorator(
              activeColor: KPrimaryColor,
              color: currentPage == 0 ? KGrey : KPrimaryColor,
            ),
          ),
          SizedBox(height: 40),
          CustomButton(
            title: 'next'.tr(),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                FirstPageAuth.routeName,
                (route) => false,
              );
            },
            isVisible: currentPage == 0 ? false : true,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
