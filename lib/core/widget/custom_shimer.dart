import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:shimmer/shimmer.dart';

/// Applies the application's themed shimmer animation to [child].
///
/// Used to build skeleton layouts that closely mirror the real widgets while
/// keeping a single, lightweight shimmer animation per section.
class ShimmerBox extends StatelessWidget {
  final Widget child;

  const ShimmerBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDarkMode = theme.brightness == Brightness.dark;

    final baseColor =
        isDarkMode
            ? Colors.grey.withValues(alpha: 0.15)
            : Colors.grey.withValues(alpha: 0.25);

    final highlightColor =
        isDarkMode
            ? theme.cardColor.withValues(alpha: 0.4)
            : theme.shadowColor.withValues(alpha: 0.3);

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child,
    );
  }
}

class CustomShimer extends StatelessWidget {
  const CustomShimer({super.key, this.height, this.width, this.radius});

  final double? height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDarkMode = theme.brightness == Brightness.dark;

    final baseColor =
        isDarkMode
            ? Colors.grey.withValues(alpha: 0.15)
            : Colors.grey.withValues(alpha: 0.25);

    final highlightColor =
        isDarkMode
            ? theme.cardColor.withValues(alpha: 0.4)
            : theme.shadowColor.withValues(alpha: 0.3);

    final containerWidth = width ?? 120;
    final containerHeight = height ?? 120;

    final avatarSize = containerHeight * .45;
    final titleWidth = containerWidth * .65;
    final subTitleWidth = containerWidth * .4;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        padding: EdgeInsets.all(containerWidth * .1),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(radius ?? 16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: .6),
              ),
            ),
            SizedBox(height: containerHeight * .08),
            Container(
              height: containerHeight * .08,
              width: titleWidth,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .6),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(height: containerHeight * .05),
            Container(
              height: containerHeight * .06,
              width: subTitleWidth,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .6),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
