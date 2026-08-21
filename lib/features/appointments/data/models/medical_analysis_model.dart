import 'package:equatable/equatable.dart';

class MedicalAnalysisModel extends Equatable {
  final int id;
  final int previewId;
  final String fileUrl;
  final DateTime? uploadedAt;

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