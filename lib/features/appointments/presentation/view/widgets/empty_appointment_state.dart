import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/utils/app_lottie.dart';

class EmptyAppointmentState extends StatelessWidget {
  const EmptyAppointmentState({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  AppLottie.calendar,
                  height: 200.h,
                  width: 200.w,
                  repeat: true,
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint(error.toString());
                    return const Icon(Icons.error);
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Text(
                    'no_appointments'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyles.H2.copyWith(
                      color: Colors.grey.withValues(alpha: 0.6),
                    ),
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
