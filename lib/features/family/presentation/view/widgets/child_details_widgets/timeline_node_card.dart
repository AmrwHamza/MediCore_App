import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/features/appointments/data/models/appointment_types.dart';
import 'package:medicore_app/features/appointments/domain/entities/privew_entity.dart';

class TimelineNodeCard extends StatelessWidget {
  final PrivewEntity preview;
  final bool isFirst;
  final bool isLast;

  const TimelineNodeCard({
    super.key,
    required this.preview,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final status = fromStringToAppointmentTypes(preview.status);
    final (color, labelKey) = _statusStyle(status);

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimelineDot(color),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: isDark ? KCardDark : Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: color.withValues(alpha: 0.2),
                      width: 1.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
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
                          _StatusBadge(color: color, labelKey: labelKey),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 13.r,
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
                      if (preview.medicine.isNotEmpty) ...[
                        SizedBox(height: 8.h),
                        _buildMedicineRow(preview.medicine),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineDot(Color color) {
    return Column(
      children: [
        Container(
          width: 14.w,
          height: 14.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: Border.all(color: color.withValues(alpha: 0.3), width: 3),
          ),
          child: Center(
            child: Container(
              width: 5.w,
              height: 5.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
        if (!isLast)
          SizedBox(
            height: 24.h,
            width: 2.w,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMedicineRow(String medicine) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: KPrimaryColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(Icons.healing_outlined, size: 14.r, color: KPrimaryColor),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              medicine,
              style: TextStyle(
                fontSize: 11.sp,
                color: KPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  (Color, String) _statusStyle(AppointmentTypes status) {
    switch (status) {
      case AppointmentTypes.complete:
        return (KSuccess, 'completed');
      case AppointmentTypes.accepted:
        return (KPrimaryColor, 'scheduled');
      case AppointmentTypes.incomplete:
        return (KWarning, 'incomplete');
      case AppointmentTypes.pending:
        return (KGrey, 'pending');
    }
  }
}

class _StatusBadge extends StatelessWidget {
  final Color color;
  final String labelKey;

  const _StatusBadge({required this.color, required this.labelKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        labelKey.tr(),
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
