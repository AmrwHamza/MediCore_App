import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/features/appointments/domain/entities/privew_entity.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/doctor_details_widgets/doctor_rating_section.dart';

class DoctorDetailsSection extends StatelessWidget {
  const DoctorDetailsSection({super.key, required this.privewEntity});

  final PrivewEntity privewEntity;

  @override
  Widget build(BuildContext context) {
    final theme = context.select(
      (ThemeProvider provider) => provider.themeData,
    );
    final isDark = theme.brightness == Brightness.dark;

    final surfaceColor = isDark ? KCardDark : Colors.white;
    final borderColor = isDark
        ? KBorderDark.withValues(alpha: 0.4)
        : Colors.grey.withValues(alpha: 0.1);
    final textColor = isDark ? Colors.white : const Color(0xFF5A7A7C);
    final mutedColor = isDark
        ? Colors.white.withValues(alpha: 0.6)
        : Colors.grey[600];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: surfaceColor.withValues(alpha: isDark ? 0.6 : 0.9),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor, width: 1.w),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: borderColor, width: 1.w),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child:
                      privewEntity.imgPath.trim().isNotEmpty
                          ? Image.network(
                            privewEntity.imgPath,
                            width: 60.r,
                            height: 60.r,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) => Image.asset(
                                  Assets.doc,
                                  width: 60.r,
                                  height: 60.r,
                                  fit: BoxFit.cover,
                                ),
                          )
                          : Image.asset(
                            Assets.doc,
                            width: 60.r,
                            height: 60.r,
                            fit: BoxFit.cover,
                          ),
                ),
              ),
              Column(
                children: [
                  Text(
                    privewEntity.doctorName,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  if (privewEntity.price != 0) ...[
                    Divider(
                      color: borderColor.withValues(alpha: 0.4),
                      height: 1.h,
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'appointment_details_preview_fees'.tr(),
                          style: TextStyle(fontSize: 13.sp, color: mutedColor),
                        ),
                        Text(
                          ' ${privewEntity.price}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: KPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: borderColor.withValues(alpha: 0.4), height: 1.h),
          SizedBox(height: 16.h),
          DoctorRatingSection(doctorId: privewEntity.doctorId),
        ],
      ),
    );
  }
}
