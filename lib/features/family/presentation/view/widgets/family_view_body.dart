import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/family/presentation/view/child_details_view.dart';
import 'package:medicore_app/features/family/presentation/view/widgets/family_member_card.dart';
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
                  return _FamilyError(
                    message: state.error,
                    isDark: isDark,
                    onRetry: () => context.read<FamilyCubit>().getChilds(),
                  );
                }

                final isLoading = state is GetFamilyLoading;
                final children =
                    (state is GetFamilySuccess)
                    ? state.children.childList
                    : const <GetChildEntity>[];

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
                        const _FamilyLoadingList()
                      else if (children.isEmpty)
                        _EmptyFamily(isDark: isDark)
                      else
                        _FamilyMembersList(children: children),
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

class _FamilyMembersList extends StatelessWidget {
  final List<GetChildEntity> children;

  const _FamilyMembersList({required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 600;

          if (isWide) {
            final cardWidth = (constraints.maxWidth - 14.w) / 2;
            return Wrap(
              spacing: 14.w,
              runSpacing: 14.h,
              children: [
                for (var i = 0; i < children.length; i++)
                  SizedBox(
                    width: cardWidth,
                    child: _buildAnimatedCard(context, children[i], i),
                  ),
              ],
            );
          }

          return Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                _buildAnimatedCard(context, children[i], i),
                if (i < children.length - 1) SizedBox(height: 12.h),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildAnimatedCard(BuildContext context, GetChildEntity child, int index) {
    return FamilyMemberCard(
      child: child,
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
  }
}

class _FamilyLoadingList extends StatelessWidget {
  const _FamilyLoadingList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          for (var i = 0; i < 3; i++) ...[
            const FamilyCardSkeleton(),
            if (i < 2) SizedBox(height: 12.h),
          ],
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
        padding: EdgeInsets.symmetric(vertical: 36.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: isDark ? KCardDark : Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: isDark ? KBorderDark : KDividerLight),
        ),
        child: Column(
          children: [
            Container(
              width: 76.r,
              height: 76.r,
              decoration: BoxDecoration(
                color: KPrimaryColor.withValues(alpha: isDark ? 0.15 : 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.family_restroom_rounded,
                size: 38.r,
                color: KPrimaryColor.withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: 16.h),
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
                height: 1.5,
                color: isDark ? KTextSecondaryDark : KGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FamilyError extends StatelessWidget {
  final String message;
  final bool isDark;
  final VoidCallback onRetry;

  const _FamilyError({
    required this.message,
    required this.isDark,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40.h),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size: 48.r,
              color: KError.withValues(alpha: 0.7),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyles.notes.copyWith(
                  color: isDark ? KTextSecondaryDark : KGrey,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: KPrimaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Text(
                'retry'.tr(),
                style: TextStyles.button.copyWith(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
