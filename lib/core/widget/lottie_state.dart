import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:medicore_app/core/helper/text_styles.dart';

class LottieState extends StatelessWidget {
  const LottieState({
    super.key,
    required this.message,
    required this.asset,
    this.color,
    this.height = 220,
    this.width = 220,
    this.padding = const EdgeInsets.all(24),
  });

  final String message;
  final String asset;
  final Color? color;
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorFiltered(
              colorFilter:
                  color != null
                      ? ColorFilter.mode(color!, BlendMode.srcIn)
                      : const ColorFilter.mode(
                        Colors.transparent,
                        BlendMode.dst,
                      ),
              child: Lottie.asset(
                asset,
                height: height.h,
                width: width.w,
                repeat: true,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint(error.toString());
                  return const Icon(Icons.error);
                },
              ),
            ),
            SizedBox(height: 20.h),
            Text(message, textAlign: TextAlign.center, style: TextStyles.H2),
          ],
        ),
      ),
    );
  }
}
