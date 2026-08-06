import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/appointments/domain/entities/privew_entity.dart';
import 'package:medicore_app/features/appointments/data/models/appointment_types.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/upload_widgets/upload_analysis_card.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/upload_widgets/uploaded_analysis_card.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/pdf_viewer_screen.dart'
    hide CustomSnackbar, SnackbarType;
import 'package:medicore_app/features/appointments/presentation/view_model/preview_upload_cubit/preview_upload_cubit.dart';
import 'package:medicore_app/features/appointments/presentation/view_model/preview_upload_cubit/upload_state.dart';

class UploadSection extends StatefulWidget {
  final PrivewEntity privewEntity;

  const UploadSection({super.key, required this.privewEntity});

  @override
  State<UploadSection> createState() => _UploadSectionState();
}

class _UploadSectionState extends State<UploadSection> {
  static const int _maxSizeBytes = 20 * 1024 * 1024;
  static const List<String> _allowedExtensions = ['pdf'];

  String? _selectedName;
  late final PreviewUploadCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = PreviewUploadCubit()..initialize(
      previewId: widget.privewEntity.id,
      existingFile: widget.privewEntity.analysisFile,
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _pickAndUpload() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: _allowedExtensions,
    );
    if (result == null || result.files.isEmpty || !mounted) return;

    final file = result.files.first;
    final path = file.path;
    if (path == null) return;

    if (file.size > _maxSizeBytes) {
      CustomSnackbar.show(
        context,
        message: 'file_too_large'.tr(),
        type: SnackbarType.error,
      );
      return;
    }

    setState(() {
      _selectedName = file.name;
    });

    _cubit.upload(
      previewId: widget.privewEntity.id,
      filePath: path,
      fileName: file.name,
    );
  }

  Future<void> _viewFile(String? fileUrl) async {
    final url = fileUrl;
    if (url == null || url.trim().isEmpty) {
      CustomSnackbar.show(
        context,
        message: 'file_preview_unavailable'.tr(),
        type: SnackbarType.error,
      );
      return;
    }

    final resolved = _resolveUrl(url);
    final lower = resolved.toLowerCase();
    
    if (lower.endsWith('.pdf')) {
      await _showPdfViewer(resolved);
    } else {
      // Fallback for non-PDF files (shouldn't happen with current restrictions)
      CustomSnackbar.show(
        context,
        message: 'only_pdf_supported'.tr(),
        type: SnackbarType.error,
      );
    }
  }

  Future<void> _showPdfViewer(String url) async {
    if (!mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(
          pdfUrl: url,
          title: widget.privewEntity.analysisFile.isNotEmpty 
              ? widget.privewEntity.analysisFile 
              : 'Medical Analysis',
        ),
      ),
    );
  }

  String _resolveUrl(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) return url;
    return '$base$url';
  }

  @override
  Widget build(BuildContext context) {
    // Uploading is strictly allowed only for "incomplete diagnosis" status.
    // Pending/waiting, accepted, and completed appointments must NOT render
    // an upload section or any dummy/placeholder picker.
    if (!canUploadMedicalAnalysis(widget.privewEntity)) {
      return const SizedBox.shrink();
    }

    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<PreviewUploadCubit, PreviewUploadState>(
        builder: (context, state) {
          if (state.isUploaded) {
            return UploadedAnalysisCard(
              isDark: isDark,
              fileName: state.fileName?.isNotEmpty == true
                  ? state.fileName!
                  : widget.privewEntity.analysisFile,
              uploadedAt: state.uploadedAt,
              onViewFile: () => _viewFile(state.fileUrl),
              onReplaceFile: _pickAndUpload,
            );
          }
          return UploadAnalysisCard(
            isDark: isDark,
            fileName: state.fileName ?? _selectedName,
            isUploading: state.isUploading,
            progress: state.progress,
            error: state.error,
            onPickFile: _pickAndUpload,
          );
        },
      ),
    );
  }
}