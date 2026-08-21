import '../../domain/entities/privew_entity.dart';

class PrivewResponseModel {
  final List<PrivewModel> completePreviews;
  final List<PrivewModel> partlyPreviews;
  final List<PrivewEntity> completeSons;
  final List<PrivewEntity> partlyPreviewsSons;

  PrivewResponseModel({
    required this.completePreviews,
    required this.partlyPreviews,
    required this.completeSons,
    required this.partlyPreviewsSons,
  });

  factory PrivewResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return PrivewResponseModel(
      completePreviews:
          (data['completePreviews'] as List)
              .map((e) => PrivewModel.fromJson(e, isChild: false))
              .toList(),
      partlyPreviews:
          (data['partlyPreviews'] as List)
              .map((e) => PrivewModel.fromJson(e, isChild: false))
              .toList(),
      completeSons:
          (data['completePreviewsSons'] as List)
              .map((e) => PrivewModel.fromJson(e, isChild: true))
              .toList(),
      partlyPreviewsSons:
          (data['partlyPreviewsSons'] as List)
              .map((e) => PrivewModel.fromJson(e, isChild: true))
              .toList(),
    );
  }
}

class PrivewModel extends PrivewEntity {
  PrivewModel({
    required super.id,
    required super.patientId,
    required super.doctorId,
    required super.departmentId,
    required super.diagnoseis,
    required super.medicine,
    required super.notes,
    required super.date,
    required super.status,
    required super.price,
    required super.createdAt,
    required super.updatedAt,
    required super.diagnoseisType,
    required super.patientName,
    required super.doctorName,
    required super.gender,
    required super.imgPath,
    required super.isChild,
    required super.appointmentId,
    super.analysisFile,
  });

  factory PrivewModel.fromJson(
    Map<String, dynamic> json, {
    required bool isChild,
  }) {
    return PrivewModel(
      id: json['id'],
      patientId: json['patient_id'],
      doctorId: json['doctor_id'],
      departmentId: json['department_id'],
      diagnoseis: json['diagnoseis'],
      medicine: json['medicine'],
      notes: json['notes'],
      date: json['date'],
      status: json['status'],
      price: json['price_after_discount'] ?? 0,
      createdAt: json['created_at'] ?? DateTime.now(),
      updatedAt: json['updated_at'],
      diagnoseisType: json['diagnoseis_type'],
      patientName: json['patientName'] ?? '',
      doctorName: json['doctorName'] ?? '',
      gender: json['gender'] ?? '',
      imgPath: json['imgPath'] ?? '',
      isChild: isChild,
      appointmentId: json['apointment_id'],
      analysisFile: _readAnalysisFile(json),
    );
  }

  static String _readAnalysisFile(Map<String, dynamic> json) {
    for (final key in const [
      'analysis_file',
      'analysisFile',
      'medical_analysis',
      'medicalAnalysis',
      'analysis_path',
      'analysisPath',
      'file',
      'file_path',
      'attachment',
      'attachment_url',
    ]) {
      final value = json[key];
      if (value is String && value.trim().isNotEmpty) return value;
    }
    return '';
  }
}
