import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_button.dart';

class UploadAnalysisCard extends StatelessWidget {
  final bool isDark;
  final String? fileName;
  final bool isUploading;
  final double progress;
  final String? error;
  final VoidCallback? onPickFile;

  const UploadAnalysisCard({
    super.key,
    required this.isDark,
    this.fileName,
    required this.isUploading,
    required this.progress,
    this.error,
    this.onPickFile,
  });

  @override
  Widget build(BuildContext context) {
    final surfaceColor = isDark ? KCardDark : Colors.white;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark
              ? KBorderDark.withValues(alpha: 0.5)
              : Colors.grey.withValues(alpha: 0.08),
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
          Text(
            'upload_medical_docs'.tr(),
            style: TextStyles.H2.copyWith(
              color: isDark ? Colors.white : KDarkBlue,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'upload_medical_docs_hint'.tr(),
            style: TextStyles.notes.copyWith(
              fontSize: 12.sp,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.6)
                  : Colors.grey[600],
              height: 1.4,
            ),
          ),
          SizedBox(height: 16.h),
          _FileNameRow(fileName: fileName, isDark: isDark),
          if (isUploading) ...[
            SizedBox(height: 12.h),
            _UploadProgress(progress: progress),
          ] else ...[
            SizedBox(height: 16.h),
            CustomButton(title: 'choose_file'.tr(), onTap: onPickFile),
          ],
          if (error != null) ...[
            SizedBox(height: 12.h),
            Text(
              error!,
              style: TextStyle(
                fontSize: 12.sp,
                color: KError,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FileNameRow extends StatelessWidget {
  final String? fileName;
  final bool isDark;

  const _FileNameRow({this.fileName, required this.isDark});

  @override
  Widget build(BuildContext context) {
    if (fileName == null || fileName!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: KPrimaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.description_outlined,
            size: 16.r,
            color: KPrimaryColor,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            fileName!,
            style: TextStyle(
              fontSize: 12.sp,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.75)
                  : Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _UploadProgress extends StatelessWidget {
  final double progress;

  const _UploadProgress({required this.progress});

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8.h,
            backgroundColor: KPrimaryColor.withValues(alpha: 0.1),
            valueColor: const AlwaysStoppedAnimation(KPrimaryColor),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              'uploading'.tr(),
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
            ),
            const Spacer(),
            Text(
              '$percent%',
              style: TextStyle(
                fontSize: 12.sp,
                color: KPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
