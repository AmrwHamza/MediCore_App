import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';

class UploadedAnalysisCard extends StatelessWidget {
  final bool isDark;
  final String fileName;
  final DateTime? uploadedAt;
  final bool isBusy;
  final String? busyLabel;
  final VoidCallback? onViewFile;
  final VoidCallback? onReplaceFile;
  final VoidCallback? onDeleteFile;

  const UploadedAnalysisCard({
    super.key,
    required this.isDark,
    required this.fileName,
    this.uploadedAt,
    this.isBusy = false,
    this.busyLabel,
    this.onViewFile,
    this.onReplaceFile,
    this.onDeleteFile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 20.r,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            Positioned(
              right: -20.r,
              top: -20.r,
              child: Container(
                width: 100.r,
                height: 100.r,
                decoration: BoxDecoration(
                  color: KPrimaryColor.withValues(alpha: 0.03),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: KPrimaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Icon(
                          _fileIcon(fileName),
                          size: 28.r,
                          color: KPrimaryColor,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'medical_analysis'.tr(),
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: KPrimaryColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              fileName,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : KDarkBlue,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (!isBusy)
                        PopupMenuButton<String>(
                          icon: Icon(
                            Icons.more_vert_rounded,
                            color: isDark ? Colors.white54 : Colors.grey,
                          ),
                          onSelected: (value) {
                            if (value == 'view') onViewFile?.call();
                            if (value == 'replace') onReplaceFile?.call();
                            if (value == 'delete') onDeleteFile?.call();
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'view',
                              child: Row(
                                children: [
                                  Icon(Icons.visibility_outlined, size: 20.r),
                                  SizedBox(width: 8.w),
                                  Text('view_pdf'.tr()),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'replace',
                              child: Row(
                                children: [
                                  Icon(Icons.sync_rounded, size: 20.r),
                                  SizedBox(width: 8.w),
                                  Text('replace_pdf'.tr()),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete_outline_rounded,
                                      size: 20.r, color: KError),
                                  SizedBox(width: 8.w),
                                  Text('delete'.tr(),
                                      style: const TextStyle(color: KError)),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14.r,
                        color: isDark ? Colors.white38 : Colors.grey,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        uploadedAt != null
                            ? '${'uploaded'.tr()} ${_formatDate(uploadedAt!)}'
                            : 'uploaded'.tr(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: isDark ? Colors.white38 : Colors.grey[600],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: KSuccess.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'uploaded'.tr().toUpperCase(),
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: KSuccess,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (isBusy) ...[
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        SizedBox(
                          width: 16.r,
                          height: 16.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: KPrimaryColor,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          busyLabel ?? 'processing'.tr(),
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: KPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton.icon(
                        onPressed: onViewFile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: KPrimaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        icon: Icon(Icons.visibility_rounded, size: 20.r),
                        label: Text(
                          'view_medical_report'.tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
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