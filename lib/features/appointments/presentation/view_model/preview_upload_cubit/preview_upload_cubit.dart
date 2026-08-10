import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/appointments/data/models/medical_analysis_model.dart';
import 'package:medicore_app/features/appointments/data/repo/appointments_repo_impl.dart';

import 'upload_state.dart';

class PreviewUploadCubit extends Cubit<PreviewUploadState> {
  PreviewUploadCubit() : super(const PreviewUploadInitial());

  int _previewId = 0;
  bool _isChild = false;
  CancelToken? _cancelToken;
  bool _uploadCancelled = false;

  Future<void> initialize({
    required int previewId,
    bool isChild = false,
  }) async {
    _previewId = previewId;
    _isChild = isChild;
    await loadAnalyses();
  }

  Future<void> loadAnalyses() async {
    if (_previewId <= 0) return;

    if (_isChild) {
      emit(state.copyWith(isAnalysesLoading: false, clearError: true));
      return;
    }

    emit(state.copyWith(isAnalysesLoading: true, clearError: true));
    final response = await getIt<AppointmentsRepoImpl>().getMedicalAnalyses(
      previewId: _previewId,
    );
    if (isClosed) return;

    response.fold(
      (failure) => emit(
        state.copyWith(isAnalysesLoading: false, error: failure.message),
      ),
      (list) => emit(state.copyWith(isAnalysesLoading: false, analyses: list)),
    );
  }

  Future<void> upload({
    required String filePath,
    required String fileName,
    int? replaceOldId,
    String category = '',
  }) async {
    if (state.isUploading) return;

    _uploadCancelled = false;
    _cancelToken = CancelToken();
    final cancelToken = _cancelToken;

    emit(
      state.copyWith(
        isUploading: true,
        progress: 0,
        selectedFileName: fileName,
        replacingId: replaceOldId,
        clearError: true,
        clearSuccess: true,
      ),
    );

    final response = await getIt<AppointmentsRepoImpl>().uploadMedicalAnalysis(
      previewId: _previewId,
      file: File(filePath),
      cancelToken: cancelToken,
      onSendProgress: (sent, total) {
        if (total <= 0) return;
        final progress = (sent / total).clamp(0.0, 1.0);
        if (isClosed) return;
        emit(state.copyWith(isUploading: true, progress: progress));
      },
    );

    if (isClosed) return;

    // A manual cancel already reset the state; ignore the aborted request.
    if (_uploadCancelled) return;

    response.fold(
      (failure) => emit(
        state.copyWith(
          isUploading: false,
          progress: 0,
          replacingId: null,
          error: failure.message,
        ),
      ),
      (uploadedFile) {
        emit(
          state.copyWith(
            isUploading: false,
            progress: 1,
            selectedFileName: null,
            successMessage: 'upload_success'.tr(),
            analyses:
                _isChild
                    ? [
                      MedicalAnalysisModel(
                        id: 0,
                        previewId: _previewId,
                        fileUrl: uploadedFile?.fileUrl ?? '',
                        uploadedAt: DateTime.now(),
                        category: category,
                      ),
                      ...state.analyses,
                    ]
                    : state.analyses,
          ),
        );

        // Reconcile with the server list so only real records are shown.
        // Child previews have no server list to reconcile with.
        if (!_isChild) {
          loadAnalyses();
        }

        // Replace: delete the old document after the new upload succeeded.
        if (replaceOldId != null && replaceOldId != 0) {
          _delete(replaceOldId);
        }
      },
    );
  }

  /// Aborts an in-progress upload (if any) and returns to the idle state.
  Future<void> cancelUpload() async {
    if (!state.isUploading) return;
    _uploadCancelled = true;
    _cancelToken?.cancel('User cancelled the upload');
    _cancelToken = null;
    emit(
      state.copyWith(
        isUploading: false,
        progress: 0,
        selectedFileName: null,
        replacingId: null,
        clearError: true,
        successMessage: 'upload_cancelled'.tr(),
      ),
    );
  }

  /// Deletes an analysis after user confirmation (the caller shows the
  /// confirmation dialog; [medicalId] == 0 marks an unsaved/temp item which is
  /// removed locally only).
  Future<void> deleteAnalysis({required int medicalId}) async {
    if (state.deletingId != null) return;
    if (medicalId == 0) {
      emit(
        state.copyWith(
          analyses: state.analyses.where((a) => a.id != medicalId).toList(),
          clearDeletingId: true,
        ),
      );
      return;
    }
    await _delete(medicalId);
  }

  Future<void> _delete(int medicalId) async {
    emit(state.copyWith(deletingId: medicalId, clearError: true));
    final response = await getIt<AppointmentsRepoImpl>().deleteMedicalAnalysis(
      medicalId: medicalId,
    );
    if (isClosed) return;

    response.fold(
      (failure) =>
          emit(state.copyWith(clearDeletingId: true, error: failure.message)),
      (message) => emit(
        state.copyWith(
          clearDeletingId: true,
          successMessage: message,
          analyses: state.analyses.where((a) => a.id != medicalId).toList(),
        ),
      ),
    );
  }

  void clearFeedback() {
    emit(state.copyWith(clearError: true, clearSuccess: true));
  }
}
