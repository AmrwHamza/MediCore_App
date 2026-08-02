import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';

import '../../../../home/domain/entities/department_entity.dart';

class DepartmentCardInDetails extends StatelessWidget {
  final DepartmentEntity department;
  final VoidCallback? onTap;

  const DepartmentCardInDetails({
    super.key,
    required this.department,
    this.onTap,
  });

  String _getAssetImage(int id) {
    final index = (id - 1) % 15;
    final imageNumber = index + 1;
    return 'assets/departments_image/D$imageNumber.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160.h,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        _getAssetImage(department.id),
                        fit: BoxFit.cover,
                        color: KPrimaryDark.withValues(alpha: 0.25),
                        colorBlendMode: BlendMode.multiply,
                        errorBuilder:
                            (context, error, stackTrace) => Container(
                              color:
                                  isDark ? Colors.grey[800] : Colors.grey[200],
                              child: const Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                              ),
                            ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.4),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Opacity(
                        opacity: 0.7,
                        child: Image.asset(
                          'assets/images/Logo_without_background.png',
                          width: 36,
                          height: 36,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    department.departmentName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: theme.canvasColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    department.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark ? Colors.white60 : Colors.grey[600],
                      fontSize: 14.sp,
                      height: 1.3,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
