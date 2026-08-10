import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/features/appointments/domain/entities/privew_entity.dart';

class DoctorDetailsSection extends StatelessWidget {
  const DoctorDetailsSection({super.key, required this.privewEntity});

  final PrivewEntity privewEntity;

  @override
  Widget build(BuildContext context) {
    final theme = context.select(
      (ThemeProvider provider) => provider.themeData,
    );
    final isDark = theme.brightness == Brightness.dark;

    final mutedColor = isDark
        ? Colors.white.withValues(alpha: 0.6)
        : Colors.grey[600];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDark ? KCardDark : Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: isDark
              ? KBorderDark.withValues(alpha: 0.3)
              : KPrimaryColor.withValues(alpha: 0.08),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black.withValues(alpha: 0.3) 
                : KPrimaryColor.withValues(alpha: 0.04),
            spreadRadius: 0,
            blurRadius: 20.r,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 70.r,
                height: 70.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: KPrimaryColor.withValues(alpha: 0.2),
                    width: 2.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: KPrimaryColor.withValues(alpha: 0.1),
                      blurRadius: 10.r,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.r),
                  child: privewEntity.imgPath.trim().isNotEmpty
                      ? Image.network(
                          privewEntity.imgPath,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Image.asset(
                            Assets.doc,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          Assets.doc,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      privewEntity.doctorName,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : KDarkBlue,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.medical_services_outlined,
                          size: 14.r,
                          color: KPrimaryColor,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'doctor'.tr(),
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: mutedColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (privewEntity.price != 0) ...[
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                          KPrimaryColor.withValues(alpha: 0.15),
                          KPrimaryColor.withValues(alpha: 0.05),
                        ]
                      : [
                          KPrimaryColor.withValues(alpha: 0.08),
                          KPrimaryColor.withValues(alpha: 0.02),
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: KPrimaryColor.withValues(alpha: 0.1),
                  width: 1.w,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: KPrimaryColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.payments_outlined,
                      size: 18.r,
                      color: KPrimaryColor,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'appointment_details_preview_fees'.tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.7)
                            : KDarkBlue.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '${privewEntity.price}',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: KPrimaryColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
