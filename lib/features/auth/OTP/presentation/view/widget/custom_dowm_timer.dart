import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:medicore_app/constants.dart';

class CountDownTimerOTP extends StatelessWidget {
  const CountDownTimerOTP({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: 200,
        height: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: KCyan,
          boxShadow: const [
            BoxShadow(spreadRadius: 5, color: Colors.white, blurRadius: 20),
          ],
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: KWhite),
        ),
        child: TimerCountdown(
          format: CountDownTimerFormat.minutesSeconds,
          endTime: DateTime.now().add(const Duration(minutes: 5)),
          onEnd: () {
            // Get.off(const RegisterView(),
            //     transition: tansition.Transition.leftToRight);
          },
        ),
      ),
    );
  }
}
