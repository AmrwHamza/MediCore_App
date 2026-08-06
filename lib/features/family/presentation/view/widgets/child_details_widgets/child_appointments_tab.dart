import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/appointments/domain/entities/privew_entity.dart';
import 'package:medicore_app/features/appointments/presentation/view/appointment_details_view.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/get_child_entity.dart';

class ChildAppointmentsTab extends StatelessWidget {
  final List<PrivewEntity> previews;
  final GetChildEntity child;

  const ChildAppointmentsTab({
    super.key,
    required this.previews,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    if (previews.isEmpty) {
      return _buildEmptyState('no_appointments'.tr());
    }

    return ListView.builder(
      padding: EdgeInsets.all(20.w),
      itemCount: previews.length,
      itemBuilder: (context, index) {
        final preview = previews[index];
        return _AppointmentTile(
          preview: preview,
          isDark: isDark,
          onTap: () {
            context.push(AppointmentDetailsView.routeName, extra: preview);
          },
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 48.r,
              color: KPrimaryColor.withValues(alpha: 0.3),
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyles.public.copyWith(
                fontSize: 14.sp,
                color: KDarkBlue.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppointmentTile extends StatelessWidget {
  final PrivewEntity preview;
  final bool isDark;
  final VoidCallback onTap;

  const _AppointmentTile({
    required this.preview,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: isDark ? KCardDark : Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color:
              isDark
                  ? KBorderDark.withValues(alpha: 0.4)
                  : Colors.grey.withValues(alpha: 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.1 : 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: KPrimaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.medical_services_outlined,
                  color: KPrimaryColor,
                  size: 16.r,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  preview.doctorName.isEmpty
                      ? 'doctor'.tr()
                      : preview.doctorName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : KDarkBlue,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: KPrimaryColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  preview.status,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: KPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 14.r,
                color: KDarkBlue.withValues(alpha: 0.5),
              ),
              SizedBox(width: 6.w),
              Text(
                preview.date,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: KDarkBlue.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          if (preview.diagnoseis.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              preview.diagnoseis,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                color: KDarkBlue.withValues(alpha: 0.5),
                height: 1.3,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
