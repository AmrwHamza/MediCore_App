import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/get_child_entity.dart';

class ChildHeroHeader extends StatelessWidget {
  final GetChildEntity child;
  final int visitsCount;

  const ChildHeroHeader({
    super.key,
    required this.child,
    required this.visitsCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMale = child.gender == 'male';

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            KPrimaryColor.withValues(alpha: 0.9),
            KPrimaryDark.withValues(alpha: 0.85),
            KOrange.withValues(alpha: 0.7),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: KPrimaryColor.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          Positioned(
            left: -10,
            bottom: -10,
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.white.withValues(alpha: 0.05),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(isMale, isDark),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildInfoColumn(isDark),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(bool isMale, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 36,
        backgroundColor: Colors.white70,
        child: SvgPicture.asset(
          fit: BoxFit.fill,
          isMale ? Assets.imagesBoy : Assets.imagesGirl,
          width: 72,
          height: 72,
        ),
      ),
    );
  }

  Widget _buildInfoColumn(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${child.firstName} ${child.lastName}',
          style: TextStyles.H2.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 8.h),
        _buildVitalChip(
          icon: Icons.cake_outlined,
          label: 'birthdate'.tr(
            namedArgs: {'birthdate': child.birthDate},
          ),
          color: Colors.white.withValues(alpha: 0.9),
        ),
        SizedBox(height: 6.h),
        _buildVitalChip(
          icon: Icons.person_outline,
          label: 'age'.tr(namedArgs: {'age': child.age.toString()}),
          color: Colors.white.withValues(alpha: 0.9),
        ),
        SizedBox(height: 6.h),
        _buildVitalChip(
          icon: Icons.local_hospital_outlined,
          label: 'visits'.tr(namedArgs: {'num': visitsCount.toString()}),
          color: Colors.white.withValues(alpha: 0.9),
        ),
      ],
    );
  }

  Widget _buildVitalChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14.r),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}