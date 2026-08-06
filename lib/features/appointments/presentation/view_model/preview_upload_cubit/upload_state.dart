import 'package:equatable/equatable.dart';

class PreviewUploadState extends Equatable {
  final bool isUploading;
  final double progress;
  final String? fileName;
  final String? fileUrl;
  final DateTime? uploadedAt;
  final bool isUploaded;
  final String? error;
  final String? successMessage;

  const PreviewUploadState({
    this.isUploading = false,
    this.progress = 0,
    this.fileName,
    this.fileUrl,
    this.uploadedAt,
    this.isUploaded = false,
    this.error,
    this.successMessage,
  });

  const PreviewUploadState.initial() : this();

  @override
  List<Object?> get props => [
    isUploading,
    progress,
    fileName,
    fileUrl,
    uploadedAt,
    isUploaded,
    error,
    successMessage,
  ];
}

final class PreviewUploadInitial extends PreviewUploadState {
  const PreviewUploadInitial() : super();
}
