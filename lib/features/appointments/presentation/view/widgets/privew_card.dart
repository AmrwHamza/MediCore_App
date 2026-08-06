import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constants.dart';
import '../../../../../core/theme/theme_provider.dart';
import '../../../data/models/appointment_types.dart';
import 'delete_appointment_button.dart';
import 'image_card.dart';

class PreviewCard extends StatelessWidget {
  final bool isChild;
  final int appointmentId;
  final String imagePath;
  final String patientName;
  final AppointmentTypes status;
  final DateTime date;
  final String doctorName;
  final bool isMale;
  final void Function()? onTap;
  final bool canDelete;

  const PreviewCard({
    super.key,
    required this.isChild,
    required this.appointmentId,
    required this.imagePath,
    required this.patientName,
    required this.status,
    required this.date,
    required this.doctorName,
    required this.isMale,
    this.onTap,
    this.canDelete = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    final done = status == AppointmentTypes.complete;

    final cardColor = isDark
        ? KCardDark
        : (done ? Colors.grey.withValues(alpha: 0.7) : Colors.white);
    final primaryTextColor = isDark
        ? Colors.white.withValues(alpha: 0.85)
        : (done ? Colors.white.withValues(alpha: 0.8) : Colors.grey[700]);
    final secondaryTextColor = isDark
        ? Colors.white.withValues(alpha: 0.6)
        : (done ? Colors.white.withValues(alpha: 0.8) : Colors.grey[600]);
    final dividerColor = isDark
        ? Colors.white.withValues(alpha: 0.1)
        : (done
            ? Colors.white.withValues(alpha: 0.3)
            : Colors.grey.withValues(alpha: 0.1));

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: isDark
              ? KBorderDark.withValues(alpha: 0.5)
              : Colors.grey.withValues(alpha: 0.08),
          width: 1.w,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.4),
            width: done ? 1 : 0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.02),
              blurRadius: 16.r,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r),
            child: Padding(
              padding: EdgeInsets.all(14.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageCard(
                    isChild: isChild,
                    imagePath: imagePath,
                    isMale: isMale,
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                patientName,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: primaryTextColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (status == AppointmentTypes.incomplete) ...[
                              SizedBox(width: 8.w),
                              _buildRelationBadge(),
                            ],
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(
                              Icons.medication_outlined,
                              size: 16.r,
                              color: KPrimaryColor.withValues(alpha: 0.7),
                            ),
                            SizedBox(width: 6.w),
                            Expanded(
                              child: Text(
                                doctorName,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: primaryTextColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Divider(
                          color: dividerColor,
                          height: 1.h,
                          thickness: 1.h,
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: KInfo.withValues(alpha: 0.08),
                                      borderRadius: BorderRadius.circular(6.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.02,
                                          ),
                                          blurRadius: 4.r,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.calendar_today_rounded,
                                      size: 13.r,
                                      color: KInfo,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    DateFormat('yyyy/MM/dd').format(date),
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                      color: secondaryTextColor,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: KSuccess.withValues(alpha: 0.08),
                                      borderRadius: BorderRadius.circular(6.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.02,
                                          ),
                                          blurRadius: 4.r,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.access_time_rounded,
                                      size: 13.r,
                                      color: KSuccessDark,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    DateFormat('hh:mm a').format(date),
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                      color: secondaryTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (canDelete) ...[
                    SizedBox(width: 14.w),
                    DeleteAppointmentButton(appointmentId: appointmentId),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRelationBadge() {
    final backgroundColor = KError.withValues(alpha: 0.08);

    final textColor = KError;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        'needs_complete'.tr(),
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
