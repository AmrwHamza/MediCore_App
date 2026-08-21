import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_shimer.dart';

class WellnessSectionSkeleton extends StatelessWidget {
  const WellnessSectionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark ? KBorderDark : Colors.grey.withValues(alpha: 0.1);

    return ShimmerBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SkeletonCard(
            borderColor: borderColor,
            radius: 24,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    _ShimmerBlock(width: 40, height: 40, radius: 12),
                    SizedBox(width: 12),
                    Expanded(child: _ShimmerBlock(height: 16, radius: 8)),
                    SizedBox(width: 12),
                    _ShimmerBlock(width: 64, height: 24, radius: 12),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    _ShimmerBlock(width: 110, height: 110, radius: 55),
                    SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _ContributionSkeletonRow(),
                          SizedBox(height: 12),
                          _ContributionSkeletonRow(),
                          SizedBox(height: 12),
                          _ContributionSkeletonRow(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      _ShimmerBlock(width: 16, height: 16, radius: 8),
                      SizedBox(width: 8),
                      Expanded(child: _ShimmerBlock(height: 10, radius: 4)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _SkeletonCard(
            borderColor: borderColor,
            radius: 22,
            padding: const EdgeInsets.all(18),
            child: const Row(
              children: [
                _ShimmerBlock(width: 52, height: 52, radius: 16),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ShimmerBlock(width: 90, height: 10, radius: 4),
                      SizedBox(height: 6),
                      _ShimmerBlock(width: 140, height: 14, radius: 4),
                      SizedBox(height: 6),
                      _ShimmerBlock(width: 100, height: 10, radius: 4),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                _ShimmerBlock(width: 56, height: 26, radius: 13),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  final Color borderColor;
  final double radius;
  final EdgeInsets padding;
  final Widget child;

  const _SkeletonCard({
    required this.borderColor,
    required this.radius,
    required this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor),
      ),
      child: child,
    );
  }
}

class _ShimmerBlock extends StatelessWidget {
  final double? width;
  final double height;
  final double radius;

  const _ShimmerBlock({this.width, required this.height, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class _ContributionSkeletonRow extends StatelessWidget {
  const _ContributionSkeletonRow();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _ShimmerBlock(width: 18, height: 18, radius: 6),
            SizedBox(width: 8),
            Expanded(child: _ShimmerBlock(height: 9, radius: 4)),
            SizedBox(width: 8),
            _ShimmerBlock(width: 28, height: 9, radius: 4),
          ],
        ),
        SizedBox(height: 5),
        _ShimmerBlock(height: 5, radius: 2),
      ],
    );
  }
}

class DepartmentSkeletonList extends StatelessWidget {
  const DepartmentSkeletonList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (_, __) => SizedBox(width: 16.w),
      itemBuilder: (_, __) => CustomShimer(width: 105.w, height: 135.h),
    );
  }
}

class DoctorsSkeletonList extends StatelessWidget {
  const DoctorsSkeletonList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (_, __) => SizedBox(width: 16.w),
      itemBuilder: (_, __) => CustomShimer(width: 165.w, height: 230.h),
    );
  }
}
