import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/features/appointments/domain/entities/privew_entity.dart';
import 'package:medicore_app/features/family/presentation/view/widgets/child_details_widgets/health_timeline_stepper.dart';

class ChildRecordsTab extends StatelessWidget {
  final List<PrivewEntity> previews;

  const ChildRecordsTab({super.key, required this.previews});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (previews.isEmpty) {
      return _buildEmptyState('no_medical_records'.tr());
    }

    return HealthTimelineStepper(previews: previews);
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.folder_open_outlined,
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