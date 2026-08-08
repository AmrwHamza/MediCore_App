import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';

import 'package:medicore_app/core/widget/custom_button.dart';

/// The "upload a new document" card, shown when a partial diagnosis has no
/// uploaded analyses yet (or after cancel/delete).
///
/// It renders as a tappable dashed drop-zone. While an upload is running it
/// switches to a progress view with a cancel action.
class UploadAnalysisCard extends StatelessWidget {
  final bool isDark;
  final String? fileName;
  final bool isUploading;
  final double progress;
  final String? error;
  final VoidCallback? onPickFile;
  final VoidCallback? onCancel;

  const UploadAnalysisCard({
    super.key,
    required this.isDark,
    this.fileName,
    required this.isUploading,
    required this.progress,
    this.error,
    this.onPickFile,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: isUploading
          ? _UploadingPanel(
              key: const ValueKey('uploading'),
              isDark: isDark,
              fileName: fileName,
              progress: progress,
              onCancel: onCancel,
            )
          : _DropZone(
              key: const ValueKey('idle'),
              isDark: isDark,
              onTap: onPickFile,
            ),
    );
  }
}

class _DropZone extends StatelessWidget {
  final bool isDark;
  final VoidCallback? onTap;

  const _DropZone({super.key, required this.isDark, this.onTap});

  @override
  Widget build(BuildContext context) {
    final borderColor = KPrimaryColor.withValues(alpha: 0.35);
    final hintColor = isDark
        ? Colors.white.withValues(alpha: 0.55)
        : Colors.grey[600];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        splashColor: KPrimaryColor.withValues(alpha: 0.08),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
          decoration: BoxDecoration(
            color: isDark
                ? KPrimaryColor.withValues(alpha: 0.05)
                : KPrimaryColor.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: borderColor, width: 1.2.w),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  color: KPrimaryColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.upload_file_rounded,
                  size: 34.r,
                  color: KPrimaryColor,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                'choose_file'.tr(),
                style: TextStyles.public.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : KDarkBlue,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'upload_medical_docs_hint'.tr(),
                style: TextStyles.notes.copyWith(
                  fontSize: 12.sp,
                  color: hintColor,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 18.h),
              CustomButton(title: 'choose_file'.tr(), onTap: onTap),
            ],
          ),
        ),
      ),
    );
  }
}

class _UploadingPanel extends StatelessWidget {
  final bool isDark;
  final String? fileName;
  final double progress;
  final VoidCallback? onCancel;

  const _UploadingPanel({
    super.key,
    required this.isDark,
    this.fileName,
    required this.progress,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round().clamp(0, 100);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDark ? KCardDark : Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: KPrimaryColor.withValues(alpha: 0.25),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.15 : 0.015),
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
              SizedBox(
                width: 22.r,
                height: 22.r,
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: KPrimaryColor,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'uploading'.tr(),
                  style: TextStyles.public.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : KDarkBlue,
                  ),
                ),
              ),
              Text(
                '$percent%',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: KPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (fileName != null && fileName!.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Text(
              fileName!,
              style: TextStyle(
                fontSize: 12.sp,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.6)
                    : Colors.grey[600],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          SizedBox(height: 14.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8.h,
                backgroundColor: KPrimaryColor.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation(
                  KPrimaryColor.withValues(alpha: 0.9),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                foregroundColor: KError,
                side: BorderSide(color: KError.withValues(alpha: 0.5)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              icon: Icon(Icons.close_rounded, size: 18.r),
              label: Text('cancel_upload'.tr()),
            ),
          ),
        ],
      ),
    );
  }
}