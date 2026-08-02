import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view_model/timer_cubit/timer_cubit.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../../../constants.dart';

class CountDownTimerOTP extends StatelessWidget {
  const CountDownTimerOTP({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? KPrimaryColor : KPrimaryDark;
    final textSecondary =
        isDark ? const Color(0xff9CA3AF) : const Color(0xff6B7280);

    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        if (state is TimerUpdated) {
          final seconds = state.secondsLeft;
          final totalDuration = 60;
          final percentage = seconds / totalDuration;
          final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
          final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
          final timeString = '$minutes:$remainingSeconds';

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xff161B22) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color:
                    isDark ? const Color(0xff30363D) : const Color(0xffE2E8F0),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularPercentIndicator(
                  radius: 22.0,
                  lineWidth: 3.5,
                  percent: percentage,
                  progressColor: primaryColor,
                  backgroundColor:
                      isDark
                          ? const Color(0xff21262D)
                          : const Color(0xffF1F5F9),
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                  animateFromLastPercent: true,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'wait_timer_otp'.tr(),
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      timeString,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
