import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/features/appointments/domain/entities/privew_entity.dart';

class DoctorDetailsSection extends StatelessWidget {
  const DoctorDetailsSection({super.key, required this.privewEntity});

  final PrivewEntity privewEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.05),
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.grey.withValues(alpha: 0.05),
                width: 1.w,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.05),
                    width: 1.w,
                  ),
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
            ),
          ),
          Column(
            children: [
              Text(
                privewEntity.doctorName,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF5A7A7C),
                ),
              ),
              SizedBox(height: 8.h),
              RatingBarIndicator(
                rating: 4.5,
                itemBuilder:
                    (context, _) =>
                        const Icon(Icons.star_rounded, color: Colors.amber),
                itemCount: 5,
                itemSize: 22.r,
                direction: Axis.horizontal,
              ),
              SizedBox(height: 14.h),
              if (privewEntity.price != 0) ...[
                Divider(color: Colors.grey.withValues(alpha: 0.1), height: 1.h),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'appointment_details_preview_fees'.tr(),
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                      ),
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
    );
  }
}
