import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/core/widget/custom_shimer.dart';

class DepartmentSkeletonList extends StatelessWidget {
  const DepartmentSkeletonList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (_, __) => SizedBox(width: 16.w),
      itemBuilder: (_, __) => CustomShimer(width: 105.w, height: 135.h),
    );
  }
}

class DoctorsSkeletonList extends StatelessWidget {
  const DoctorsSkeletonList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (_, __) => SizedBox(width: 16.w),
      itemBuilder: (_, __) => CustomShimer(width: 165.w, height: 230.h),
    );
  }
}
