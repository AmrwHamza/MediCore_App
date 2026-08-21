import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/core/widget/custom_shimer.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/get_child_entity.dart';

class FamilyMemberCard extends StatelessWidget {
  final GetChildEntity child;
  final VoidCallback onTap;

  const FamilyMemberCard({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;
    final isMale = child.gender.toLowerCase() == 'male';
    final name = '${child.firstName} ${child.lastName}';
    final accent = isMale ? KInfo : const Color(0xFFEC6BA0);
    final bloodType =
        child.bloodType?.isNotEmpty == true ? child.bloodType! : '--';
    final isRtl = Directionality.of(context).name == 'rtl';

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: isDark ? KCardDark : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color:
                  isDark
                      ? Colors.white.withValues(alpha: 0.06)
                      : KPrimaryColor.withValues(alpha: 0.08),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.12 : 0.03),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.r, vertical: 12.r),
          child: Row(
            children: [
              _ChildAvatar(isMale: isMale, accent: accent),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.H2.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : KBlack,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      isMale ? 'son'.tr() : 'daughter'.tr(),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: accent,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 4.h,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _InfoPill(
                          icon: Icons.cake_rounded,
                          text: 'years_old'.tr(
                            namedArgs: {'age': '${child.age}'},
                          ),
                          color: accent,
                          isDark: isDark,
                        ),
                        if (child.bloodType?.isNotEmpty == true)
                          _InfoPill(
                            icon: Icons.bloodtype_rounded,
                            text: bloodType,
                            color: KError,
                            isDark: isDark,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 34.r,
                height: 34.r,
                decoration: BoxDecoration(
                  color: KPrimaryColor.withValues(alpha: isDark ? 0.16 : 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isRtl
                      ? Icons.arrow_back_ios_new_rounded
                      : Icons.arrow_forward_ios_rounded,
                  size: 14.r,
                  color: KPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChildAvatar extends StatelessWidget {
  final bool isMale;
  final Color accent;

  const _ChildAvatar({required this.isMale, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56.r,
      height: 56.r,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        shape: BoxShape.circle,
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: SvgPicture.asset(
        isMale ? Assets.imagesBoy : Assets.imagesGirl,
        width: 36.r,
        height: 36.r,
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final bool isDark;

  const _InfoPill({
    required this.icon,
    required this.text,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.r, vertical: 5.r),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.16 : 0.09),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.r, color: color),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : KBlack,
            ),
          ),
        ],
      ),
    );
  }
}

class FamilyCardSkeleton extends StatelessWidget {
  const FamilyCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return ShimmerBox(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.r, vertical: 12.r),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color:
                isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : KPrimaryColor.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          children: [
            _ShimmerCircle(radius: 28.r),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ShimmerLine(width: 140.w, height: 14.r, radius: 4.r),
                  SizedBox(height: 8.h),
                  _ShimmerLine(width: 60.w, height: 9.r, radius: 4.r),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      _ShimmerPill(width: 90.w),
                      SizedBox(width: 8.w),
                      _ShimmerPill(width: 54.w),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            _ShimmerCircle(radius: 17.r),
          ],
        ),
      ),
    );
  }
}

class _ShimmerCircle extends StatelessWidget {
  final double radius;

  const _ShimmerCircle({required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.6),
      ),
    );
  }
}

class _ShimmerLine extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const _ShimmerLine({
    required this.width,
    required this.height,
    required this.radius,
  });

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

class _ShimmerPill extends StatelessWidget {
  final double width;

  const _ShimmerPill({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 24.r,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20.r),
      ),
    );
  }
}
