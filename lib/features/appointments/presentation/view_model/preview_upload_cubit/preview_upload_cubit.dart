import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/appointments/data/models/uploaded_analysis_file.dart';
import 'package:medicore_app/features/appointments/data/repo/appointments_repo_impl.dart';

import 'upload_state.dart';

class PreviewUploadCubit extends Cubit<PreviewUploadState> {
  PreviewUploadCubit() : super(const PreviewUploadInitial());

  Future<void> initialize({
    required int previewId,
    String existingFile = '',
  }) async {
    if (existingFile.trim().isNotEmpty) {
      emit(
        PreviewUploadState(
          isUploaded: true,
          fileName: UploadedAnalysisFile.fileNameFromPath(existingFile),
          fileUrl: existingFile,
          uploadedAt: DateTime.now(),
        ),
      );
      return;
    }

    final cached = await getIt<AppointmentsRepoImpl>().getCachedAnalysis(
      previewId: previewId,
    );
    if (isClosed) return;

    if (cached != null) {
      emit(
        PreviewUploadState(
          isUploaded: true,
          fileName: cached.fileName,
          fileUrl: cached.fileUrl,
          uploadedAt: cached.uploadedAt,
        ),
      );
    }
  }

  Future<void> upload({
    required int previewId,
    required String filePath,
    required String fileName,
  }) async {
    emit(
      const PreviewUploadState(isUploading: true, progress: 0),
    );

    final response = await getIt<AppointmentsRepoImpl>()
        .uploadMedicalAnalysis(
          previewId: previewId,
          file: File(filePath),
          onSendProgress: (sent, total) {
            if (total <= 0) return;
            final progress = (sent / total).clamp(0.0, 1.0);
            if (isClosed) return;
            emit(
              PreviewUploadState(
                isUploading: true,
                progress: progress,
                fileName: fileName,
              ),
            );
          },
        );

    if (isClosed) return;

    response.fold(
      (failure) => emit(
        PreviewUploadState(
          isUploading: false,
          progress: 0,
          fileName: fileName,
          error: failure.message,
        ),
      ),
      (uploadedFile) async {
        final file =
            uploadedFile ??
            UploadedAnalysisFile(
              fileName: fileName,
              fileUrl: null,
              uploadedAt: DateTime.now(),
            );
        await getIt<AppointmentsRepoImpl>().cacheAnalysis(
          previewId: previewId,
          file: file,
        );
        if (isClosed) return;
        emit(
          PreviewUploadState(
            isUploading: false,
            progress: 1,
            fileName: file.fileName,
            fileUrl: file.fileUrl,
            uploadedAt: file.uploadedAt,
            isUploaded: true,
          ),
        );
      },
    );
  }
}
