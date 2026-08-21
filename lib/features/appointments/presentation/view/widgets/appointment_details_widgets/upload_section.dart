import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/appointments/data/models/appointment_types.dart';
import 'package:medicore_app/features/appointments/data/models/medical_analysis_model.dart';
import 'package:medicore_app/features/appointments/domain/entities/privew_entity.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/pdf_viewer_screen.dart'
    hide CustomSnackbar, SnackbarType;
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/upload_widgets/upload_analysis_card.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/upload_widgets/uploaded_analysis_card.dart';
import 'package:medicore_app/features/appointments/presentation/view_model/preview_upload_cubit/preview_upload_cubit.dart';
import 'package:medicore_app/features/appointments/presentation/view_model/preview_upload_cubit/upload_state.dart';

class UploadSection extends StatefulWidget {
  final PrivewEntity privewEntity;
  final bool readOnly;

  const UploadSection({
    super.key,
    required this.privewEntity,
    this.readOnly = false,
  });

  @override
  State<UploadSection> createState() => _UploadSectionState();
}

class _UploadSectionState extends State<UploadSection> {
  static const int _maxSizeBytes = 20 * 1024 * 1024;
  static const List<String> _allowedExtensions = ['pdf'];

  late final PreviewUploadCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = PreviewUploadCubit()
      ..initialize(
        previewId: widget.privewEntity.id,
        isChild: widget.privewEntity.isChild,
      );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _pickAndUpload({int? replaceOldId, String category = ''}) async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: _allowedExtensions,
    );
    if (result.isEmpty || !mounted) return;

    final file = result.first;
    final path = file.path;
    if (path == null) return;

    if (!_isPdf(file.name)) {
      CustomSnackbar.show(
        context,
        message: 'only_pdf_supported'.tr(),
        type: SnackbarType.error,
      );
      return;
    }

    if (await file.length() > _maxSizeBytes) {
      _showErrorFeedback('file_too_large'.tr());
      return;
    }

    await _cubit.upload(
      filePath: path,
      fileName: file.name,
      replaceOldId: replaceOldId,
      category: category,
    );
  }

  bool _isPdf(String name) => name.toLowerCase().endsWith('.pdf');

  Future<void> _confirmAndDelete(MedicalAnalysisModel analysis) async {
    if (analysis.id == 0) {
      _cubit.deleteAnalysis(medicalId: analysis.id);
      return;
    }
    final confirmed = await showConfirmationDialog(context);
    if (confirmed == true && mounted) {
      await _cubit.deleteAnalysis(medicalId: analysis.id);
    }
  }

  Future<void> _viewFile(MedicalAnalysisModel analysis) async {
    if (analysis.fileUrl.trim().isEmpty) {
      _showSnackbar('file_preview_unavailable'.tr(), SnackbarType.error);
      return;
    }
    final resolved = _resolveUrl(analysis.fileUrl);
    if (!_isPdf(resolved)) {
      _showSnackbar('only_pdf_supported'.tr(), SnackbarType.error);
      return;
    }
    if (!mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(
          pdfUrl: resolved,
          title:
              analysis.displayName.isNotEmpty
                  ? analysis.displayName
                  : 'Medical Analysis',
        ),
      ),
    );
  }

  Future<bool?> showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('delete_analysis_title'.tr(), textAlign: TextAlign.center),
          content: Text(
            'delete_analysis_message'.tr(),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('cancel'.tr()),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: KError,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: Text('delete_action'.tr()),
            ),
          ],
        );
      },
    );
  }

  String _resolveUrl(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) return url;
    return '$base$url';
  }

  void _showFeedback(String? message, {required bool isError}) {
    if (message == null || message.isEmpty) return;
    if (!mounted) return;
    CustomSnackbar.show(
      context,
      message: message,
      type: isError ? SnackbarType.error : SnackbarType.success,
    );
  }

  void _showSnackbar(String message, SnackbarType type) {
    if (!mounted) return;
    CustomSnackbar.show(context, message: message, type: type);
  }

  void _showErrorFeedback(String message) =>
      _showSnackbar(message, SnackbarType.error);

  @override
  Widget build(BuildContext context) {

    final isPartial = canUploadMedicalAnalysis(widget.privewEntity);
    final isComplete = isCompletedDiagnosis(widget.privewEntity);
    if (!isPartial && !isComplete) return const SizedBox.shrink();

    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;
    final allowed = isComplete ? widget.readOnly : true;

    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<PreviewUploadCubit, PreviewUploadState>(
        listener: (context, state) {
          final feedback = state.error ?? state.successMessage;
          if (feedback != null) {
            _showFeedback(feedback, isError: state.error != null);
            _cubit.clearFeedback();
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(isDark: isDark),
              SizedBox(height: 16.h),
              if (state.isAnalysesLoading && state.analyses.isEmpty)
                const _Loading()
              else if (state.analyses.isEmpty)
                _buildEmpty(context, state, isDark, allowedToUpload: allowed)
              else
                _buildList(context, state, isDark, allowedToUpload: allowed),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmpty(
    BuildContext context,
    PreviewUploadState state,
    bool isDark, {
    required bool allowedToUpload,
  }) {
    if (!allowedToUpload) {
      return _EmptyReadOnly(isDark: isDark);
    }
    return UploadAnalysisCard(
      isDark: isDark,
      fileName: state.selectedFileName,
      isUploading: state.isUploading,
      progress: state.progress,
      error: state.error,
      onPickFile: () => _pickAndUpload(),
      onCancel: () => _cubit.cancelUpload(),
    );
  }

  Widget _buildList(
    BuildContext context,
    PreviewUploadState state,
    bool isDark, {
    required bool allowedToUpload,
  }) {
    final grouped = <String, List<MedicalAnalysisModel>>{};
    for (final analysis in state.analyses) {
      grouped.putIfAbsent(analysis.category, () => []).add(analysis);
    }

    final children = <Widget>[
      if (state.isUploading)
        Padding(
          padding: EdgeInsets.only(bottom: 14.h),
          child: UploadAnalysisCard(
            isDark: isDark,
            fileName: state.selectedFileName,
            isUploading: true,
            progress: state.progress,
            onCancel: () => _cubit.cancelUpload(),
          ),
        ),
      for (final group in grouped.entries)
        ..._buildSection(
          state,
          isDark,
          allowedToUpload: allowedToUpload,
          category: group.key,
          files: group.value,
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  List<Widget> _buildSection(
    PreviewUploadState state,
    bool isDark, {
    required bool allowedToUpload,
    required String category,
    required List<MedicalAnalysisModel> files,
  }) {
    return [
      _SectionHeader(
        isDark: isDark,
        title: category.isEmpty ? 'medical_analysis'.tr() : category,
        count: files.length,
      ),
      for (final analysis in files) ...[
        SizedBox(height: 12.h),
        UploadedAnalysisCard(
          isDark: isDark,
          fileName: analysis.displayName,
          uploadedAt: analysis.uploadedAt,
          isBusy: state.deletingId == analysis.id ||
              state.replacingId == analysis.id,
          busyLabel: (state.replacingId == analysis.id &&
                  state.deletingId != analysis.id)
              ? 'replacing_file'.tr()
              : 'deleting'.tr(),
          onViewFile: () => _viewFile(analysis),
          onReplaceFile: allowedToUpload
              ? () => _pickAndUpload(replaceOldId: analysis.id, category: category)
              : null,
          onDeleteFile: allowedToUpload
              ? () => _confirmAndDelete(analysis)
              : null,
        ),
      ],
      if (allowedToUpload) ...[
        SizedBox(height: 8.h),
        TextButton.icon(
          onPressed: state.isUploading
              ? null
              : () => _pickAndUpload(category: category),
          icon: const Icon(
            Icons.add_circle_outline_rounded,
            color: KPrimaryColor,
          ),
          label: Text(
            category.isEmpty
                ? 'add_another_document'.tr()
                : '${'add_analysis_to'.tr()} $category',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: KPrimaryColor,
            ),
          ),
        ),
      ],
      SizedBox(height: 8.h),
    ];
  }
}

class _Header extends StatelessWidget {
  final bool isDark;

  const _Header({required this.isDark});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: KPrimaryColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            Icons.medication_outlined,
            size: 18.r,
            color: KPrimaryColor,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'medical_analysis'.tr(),
                style: TextStyles.H2.copyWith(
                  color: isDark ? Colors.white : KDarkBlue,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'medical_analysis_hint'.tr(),
                style: TextStyles.notes.copyWith(
                  fontSize: 12.sp,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.6)
                      : Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final bool isDark;
  final String title;
  final int count;

  const _SectionHeader({
    required this.isDark,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(7.r),
          decoration: BoxDecoration(
            color: KPrimaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: Icon(
            Icons.biotech_rounded,
            size: 16.r,
            color: KPrimaryColor,
          ),
        ),
        SizedBox(width: 9.w),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : KDarkBlue,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: KPrimaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: KPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        children: [
          SizedBox(
            width: 28.r,
            height: 28.r,
            child: const CircularProgressIndicator(
              strokeWidth: 3,
              color: KPrimaryColor,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'loading_analyses'.tr(),
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF7C8283),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyReadOnly extends StatelessWidget {
  final bool isDark;

  const _EmptyReadOnly({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? KCardDark : Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
          width: 1.w,
        ),
      ),
      child: Text(
        'no_analysis_uploaded'.tr(),
        style: TextStyle(
          fontSize: 13.sp,
          color: isDark
              ? Colors.white.withValues(alpha: 0.6)
              : Colors.grey[600],
        ),
      ),
    );
  }
}