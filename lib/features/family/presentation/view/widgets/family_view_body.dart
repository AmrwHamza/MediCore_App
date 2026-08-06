import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/core/widget/custom_shimer.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/family/presentation/view/child_details_view.dart';
import 'package:medicore_app/features/family/presentation/view_model/family_cubit/family_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/get_child_entity.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_cubit/children_info_cubit.dart';

class FamilyViewBody extends StatelessWidget {
  const FamilyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return RefreshIndicator.adaptive(
      color: theme.splashColor,
      backgroundColor: theme.cardColor,
      onRefresh: () async {
        context.read<FamilyCubit>().getChilds();
        return Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          BlocListener<ChildrenInfoCubit, ChildrenInfoState>(
            listener: (context, childState) {
              if (childState is AddChildSuccess) {
                CustomSnackbar.show(
                  context,
                  message: childState.child.message,
                  type: SnackbarType.success,
                );
                context.read<FamilyCubit>().getChilds();
              } else if (childState is DeleteChildSuccess) {
                CustomSnackbar.show(
                  context,
                  message: childState.message,
                  type: SnackbarType.success,
                );
                context.read<FamilyCubit>().getChilds();
              } else if (childState is ChildFailure) {
                CustomSnackbar.show(
                  context,
                  message: childState.error,
                  type: SnackbarType.error,
                );
              }
            },
            child: BlocBuilder<FamilyCubit, FamilyState>(
              builder: (context, state) {
                if (state is GetFamilyFailure) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text(
                        state.error,
                        style: TextStyles.H2.copyWith(color: KError),
                      ),
                    ),
                  );
                }

                final isLoading = state is GetFamilyLoading;
                final children =
                    (state is GetFamilySuccess) ? state.children.childList : [];

                return Padding(
                  padding: EdgeInsets.only(top: 16.h, bottom: 96.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            Container(
                              width: 4.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                color: KPrimaryColor,
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'my_family'.tr(),
                              style: TextStyles.H2.copyWith(
                                color: isDark ? Colors.white : KDarkBlue,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            if (children.isNotEmpty)
                              Text(
                                '${children.length} ${'family_members'.tr()}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.5)
                                      : KGrey,
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      if (isLoading)
                        SizedBox(
                          height: 232.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            itemCount: 4,
                            separatorBuilder: (_, _) =>
                                SizedBox(width: 14.w),
                            itemBuilder: (context, index) =>
                                const CustomShimer(),
                          ),
                        )
                      else if (children.isEmpty)
                        _EmptyFamily(isDark: isDark)
                      else
                        SizedBox(
                          height: 232.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            itemCount: children.length,
                            separatorBuilder: (_, _) => SizedBox(width: 14.w),
                            itemBuilder: (context, index) {
                              final child = children[index];
                              return FamilyMemberCard(
                                child: child,
                                isDark: isDark,
                                onTap: () {
                                  context.push(
                                    ChildDetailsView.routeName,
                                    extra: {'child': child},
                                  );
                                },
                              ).animate().fade(
                                duration: 420.ms,
                                delay: Duration(milliseconds: 90 * index),
                              ).slideX(
                                begin: 0.08,
                                end: 0,
                                duration: 420.ms,
                                delay: Duration(milliseconds: 90 * index),
                                curve: Curves.easeOut,
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyFamily extends StatelessWidget {
  final bool isDark;

  const _EmptyFamily({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 40.h),
        decoration: BoxDecoration(
          color: isDark ? KCardDark : Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isDark ? KBorderDark : KDividerLight,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.family_restroom_rounded,
              size: 56.r,
              color: KPrimaryColor.withValues(alpha: 0.5),
            ),
            SizedBox(height: 12.h),
            Text(
              'no_children_yet'.tr(),
              style: TextStyles.H2.copyWith(
                color: isDark ? Colors.white : KDarkBlue,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'no_children_yet_desc'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: isDark ? KTextSecondaryDark : KGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyMemberCard extends StatelessWidget {
  final GetChildEntity child;
  final bool isDark;
  final VoidCallback onTap;

  const FamilyMemberCard({
    super.key,
    required this.child,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMale = child.gender.toLowerCase() == 'male';
    final name = '${child.firstName} ${child.lastName}';
    final boyColor = isDark ? const Color(0xFF1E293B) : const Color(0xFFF0F7FF);
    final girlColor = isDark ? const Color(0xFF2D1B2D) : const Color(0xFFFFF0F5);
    final accent = isMale ? KInfo : const Color(0xFFEC6BA0);
    final bloodType = child.bloodType?.isNotEmpty == true ? child.bloodType! : '--';

    return SizedBox(
      width: 176.w,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              isMale ? boyColor : girlColor,
              isDark ? KCardDark : Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.06)
                : KPrimaryColor.withValues(alpha: 0.08),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.15 : 0.04),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(24.r),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(14.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 52.r,
                        height: 52.r,
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: accent.withValues(alpha: 0.25),
                          ),
                        ),
                        child: SvgPicture.asset(
                          isMale ? Assets.imagesBoy : Assets.imagesGirl,
                          width: 36.r,
                          height: 36.r,
                        ),
                      ),
                      const Spacer(),
                      _Pill(
                        icon: Icons.bloodtype_rounded,
                        text: bloodType,
                        color: KError,
                        isDark: isDark,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.H2.copyWith(
                      color: isDark ? Colors.white : KBlack,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      _Pill(
                        icon: Icons.cake_rounded,
                        text: '${child.age} ${'years'.tr()}',
                        color: accent,
                        isDark: isDark,
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.r,
                          vertical: 6.r,
                        ),
                        decoration: BoxDecoration(
                          color: KPrimaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'view_profile'.tr(),
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: KPrimaryColor,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 14.r,
                              color: KPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final bool isDark;

  const _Pill({
    required this.icon,
    required this.text,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.18 : 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.r, color: color),
          SizedBox(width: 3.w),
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