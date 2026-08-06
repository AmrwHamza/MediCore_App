import 'package:equatable/equatable.dart';

class UploadedAnalysisFile extends Equatable {
  final String fileName;
  final String? fileUrl;
  final DateTime uploadedAt;

  const UploadedAnalysisFile({
    required this.fileName,
    this.fileUrl,
    required this.uploadedAt,
  });

  factory UploadedAnalysisFile.fromJson(Map<String, dynamic> json) {
    return UploadedAnalysisFile(
      fileName: json['fileName'] ?? json['file_name'] ?? '',
      fileUrl: json['fileUrl'] ?? json['file_url'],
      uploadedAt: DateTime.tryParse(
            json['uploadedAt'] ?? json['uploaded_at'] ?? '',
          ) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'fileUrl': fileUrl,
      'uploadedAt': uploadedAt.toIso8601String(),
    };
  }

  static String fileNameFromPath(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return trimmed;
    return trimmed.split('/').last.split('\\').last;
  }

  @override
  List<Object?> get props => [fileName, fileUrl, uploadedAt];
}
