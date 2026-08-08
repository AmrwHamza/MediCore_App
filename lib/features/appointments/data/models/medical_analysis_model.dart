import 'package:equatable/equatable.dart';

/// Represents a single medical analysis document returned by
/// `GET /getMedicalAnalysis/{preview_id}`.
///
/// Backend contract (Envelope 1):
/// ```json
/// {
///   "id": 12,
///   "patient_id": "104682",
///   "preview_id": 45,
///   "medical_analysis_path": "https://.../medical_analyses/file.pdf",
///   "created_at": "2026-08-03 09:05:00",
///   "updated_at": "2026-08-03 09:05:00"
/// }
/// ```
class MedicalAnalysisModel extends Equatable {
  final int id;
  final int previewId;
  final String fileUrl;
  final DateTime? uploadedAt;

  /// Analysis category/section (e.g. "Blood", "Urine"). Empty when the backend
  /// does not group analyses; the UI then falls back to a single section.
  final String category;

  const MedicalAnalysisModel({
    required this.id,
    required this.previewId,
    required this.fileUrl,
    this.uploadedAt,
    this.category = '',
  });

  factory MedicalAnalysisModel.fromJson(Map<String, dynamic> json) {
    return MedicalAnalysisModel(
      id: json['id'] is num ? (json['id'] as num).toInt() : 0,
      previewId: json['preview_id'] is num
          ? (json['preview_id'] as num).toInt()
          : 0,
      fileUrl:
          (json['medical_analysis_path'] ?? json['url'] ?? json['path'] ?? '')
              .toString(),
      uploadedAt: DateTime.tryParse(
        (json['created_at'] ?? '').toString(),
      ),
      category: _readCategory(json),
    );
  }

  static String _readCategory(Map<String, dynamic> json) {
    for (final key in const [
      'category',
      'analysis_category',
      'analysis_type',
      'section',
      'type',
      'name',
    ]) {
      final value = json[key];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }
    return '';
  }

  /// Fallback display name. The backend only returns a URL, so we derive the
  /// filename when possible and otherwise fall back to a stable label.
  String get displayName {
    final trimmed = fileUrl.trim();
    if (trimmed.isEmpty) return 'Medical Analysis';
    final lastSegment = trimmed.split('/').last.split('\\').last;
    if (lastSegment.isEmpty) return 'Medical Analysis';
    if (lastSegment.contains('.')) return lastSegment;
    return 'Medical Analysis';
  }

  @override
  List<Object?> get props => [id, previewId, fileUrl, uploadedAt, category];
}