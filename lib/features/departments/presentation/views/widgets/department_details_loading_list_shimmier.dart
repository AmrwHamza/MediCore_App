import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/core/widget/custom_shimer.dart';

class DepartmentDetailsLoadingListShimmier extends StatelessWidget {
  const DepartmentDetailsLoadingListShimmier({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? Theme.of(context).cardColor : Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomShimer(
                  height: 160.h,
                  width: double.infinity,
                  radius: 16.r,
                ),
                Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomShimer(height: 20.h, width: 150.w, radius: 4.r),
                      SizedBox(height: 12.h),
                      CustomShimer(
                        height: 14.h,
                        width: double.infinity,
                        radius: 4.r,
                      ),
                      SizedBox(height: 8.h),
                      CustomShimer(height: 14.h, width: 200.w, radius: 4.r),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }, childCount: 3),
    );
  }
}
