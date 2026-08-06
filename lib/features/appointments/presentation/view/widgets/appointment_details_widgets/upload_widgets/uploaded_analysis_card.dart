import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';

class UploadedAnalysisCard extends StatelessWidget {
  final bool isDark;
  final String fileName;
  final DateTime? uploadedAt;
  final VoidCallback? onViewFile;
  final VoidCallback? onReplaceFile;

  const UploadedAnalysisCard({
    super.key,
    required this.isDark,
    required this.fileName,
    this.uploadedAt,
    this.onViewFile,
    this.onReplaceFile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDark ? KCardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: KSuccess.withValues(alpha: 0.3),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.15 : 0.015),
            spreadRadius: 0,
            blurRadius: 16.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: const BoxDecoration(
                  color: KSuccess,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 16.r,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  'uploaded_analysis_title'.tr(),
                  style: TextStyles.H2.copyWith(
                    color: isDark ? Colors.white : KDarkBlue,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: KSuccessLight.withValues(alpha: isDark ? 0.12 : 0.6),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: KPrimaryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    _fileIcon(fileName),
                    size: 22.r,
                    color: KPrimaryColor,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName,
                        style: TextStyles.public.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : KDarkBlue,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (uploadedAt != null) ...[
                        SizedBox(height: 4.h),
                        Text(
                          '${'uploaded_on'.tr()} ${_formatDate(uploadedAt!)}',
                          style: TextStyles.notes.copyWith(
                            fontSize: 11.sp,
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.6)
                                : Colors.grey[600],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  isDark: isDark,
                  icon: Icons.visibility_outlined,
                  label: 'view_file'.tr(),
                  onTap: onViewFile,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _ActionButton(
                  isDark: isDark,
                  icon: Icons.edit_outlined,
                  label: 'replace_file'.tr(),
                  onTap: onReplaceFile,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _fileIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.endsWith('.pdf')) return Icons.picture_as_pdf_outlined;
    if (lower.endsWith('.doc') || lower.endsWith('.docx')) {
      return Icons.description_outlined;
    }
    if (lower.endsWith('.mp4') || lower.endsWith('.mp3')) {
      return Icons.play_circle_outline_rounded;
    }
    const imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp'];
    if (imageExtensions.any(lower.endsWith)) return Icons.image_outlined;
    return Icons.attach_file_rounded;
  }

  String _formatDate(DateTime date) {
    final local = date.toLocal();
    return '${_twoDigits(local.day)}/${_twoDigits(local.month)}/${local.year}';
  }

  String _twoDigits(int value) => value.toString().padLeft(2, '0');
}

class _ActionButton extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.isDark,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: KPrimaryColor.withValues(alpha: isDark ? 0.15 : 0.08),
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18.r, color: KPrimaryColor),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: KPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
