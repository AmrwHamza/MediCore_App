import 'package:equatable/equatable.dart';
import 'package:medicore_app/features/appointments/data/models/medical_analysis_model.dart';

/// Holds the full state of the Medical Analysis flow for a single preview.
///
/// Distinct flags are used for each async operation so one action (e.g. a
/// delete) never disables an unrelated action (e.g. viewing a document).
class PreviewUploadState extends Equatable {
  final bool isAnalysesLoading;
  final List<MedicalAnalysisModel> analyses;
  final bool isUploading;
  final double progress;
  final String? selectedFileName;
  final int? deletingId;
  final int? replacingId;
  final String? error;
  final String? successMessage;

  const PreviewUploadState({
    this.isAnalysesLoading = false,
    this.analyses = const [],
    this.isUploading = false,
    this.progress = 0,
    this.selectedFileName,
    this.deletingId,
    this.replacingId,
    this.error,
    this.successMessage,
  });

  const PreviewUploadState.initial() : this();

  PreviewUploadState copyWith({
    bool? isAnalysesLoading,
    List<MedicalAnalysisModel>? analyses,
    bool? isUploading,
    double? progress,
    String? selectedFileName,
    int? deletingId,
    bool clearDeletingId = false,
    int? replacingId,
    bool clearReplacingId = false,
    String? error,
    bool clearError = false,
    String? successMessage,
    bool clearSuccess = false,
  }) {
    return PreviewUploadState(
      isAnalysesLoading: isAnalysesLoading ?? this.isAnalysesLoading,
      analyses: analyses ?? this.analyses,
      isUploading: isUploading ?? this.isUploading,
      progress: progress ?? this.progress,
      selectedFileName: selectedFileName ?? this.selectedFileName,
      deletingId: clearDeletingId ? null : (deletingId ?? this.deletingId),
      replacingId: clearReplacingId
          ? null
          : (replacingId ?? this.replacingId),
      error: clearError ? null : (error ?? this.error),
      successMessage: clearSuccess
          ? null
          : (successMessage ?? this.successMessage),
    );
  }

  @override
  List<Object?> get props => [
    isAnalysesLoading,
    analyses,
    isUploading,
    progress,
    selectedFileName,
    deletingId,
    replacingId,
    error,
    successMessage,
  ];
}

final class PreviewUploadInitial extends PreviewUploadState {
  const PreviewUploadInitial() : super();
}