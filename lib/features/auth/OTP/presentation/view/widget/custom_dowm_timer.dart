import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view_model/timer_cubit/timer_cubit.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class CountDownTimerOTP extends StatelessWidget {
  const CountDownTimerOTP({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        if (state is TimerUpdated) {
          final seconds = state.secondsLeft;
          final totalDuration = 60;
          final percentage = seconds / totalDuration;
          final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
          final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
          final timeString = '$minutes:$remainingSeconds';

          return Column(
            children: [
              Text(
                'wait_timer_otp'.tr(),
                style: TextStyles.public.copyWith(
                  color: Provider.of<ThemeProvider>(
                    context,
                  ).themeData.canvasColor.withAlpha((255 * 0.9).round()),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 50.0,
                      lineWidth: 8.0,
                      percent: percentage,
                      center: Text(
                        timeString,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: KCyan,
                        ),
                      ),
                      progressColor: KCyan,
                      backgroundColor: Colors.grey[300]!,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
