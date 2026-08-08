import 'package:flutter_test/flutter_test.dart';
import 'package:medicore_app/features/appointments/data/models/medical_analysis_model.dart';

void main() {
  group('MedicalAnalysisModel.fromJson', () {
    test('parses a full analysis envelope', () {
      final json = {
        'id': 12,
        'preview_id': 45,
        'medical_analysis_path':
            'https://api.example.com/medical_analyses/report.pdf',
        'created_at': '2026-08-03 09:05:00',
        'updated_at': '2026-08-03 09:05:00',
      };

      final model = MedicalAnalysisModel.fromJson(json);

      expect(model.id, 12);
      expect(model.previewId, 45);
      expect(model.fileUrl, 'https://api.example.com/medical_analyses/report.pdf');
      expect(model.uploadedAt, isNotNull);
      expect(model.uploadedAt!.year, 2026);
    });

    test('falls back to url / path keys when medical_analysis_path is absent',
        () {
      final viaUrl = MedicalAnalysisModel.fromJson({
        'id': 1,
        'preview_id': 2,
        'url': 'https://x.test/a.pdf',
      });
      final viaPath = MedicalAnalysisModel.fromJson({
        'id': 1,
        'preview_id': 2,
        'path': 'https://x.test/b.pdf',
      });

      expect(viaUrl.fileUrl, 'https://x.test/a.pdf');
      expect(viaPath.fileUrl, 'https://x.test/b.pdf');
    });

    test('defaults id and previewId to 0 when missing or non-numeric', () {
      final model = MedicalAnalysisModel.fromJson({
        'id': 'nope',
        'preview_id': null,
        'created_at': '2026-08-03 09:05:00',
      });

      expect(model.id, 0);
      expect(model.previewId, 0);
    });

    test('parses the analysis category from supported keys', () {
      final byCategory = MedicalAnalysisModel.fromJson({
        'id': 2,
        'preview_id': 3,
        'medical_analysis_path': 'https://x.test/urine.pdf',
        'category': 'Urine',
      });
      final byType = MedicalAnalysisModel.fromJson({
        'id': 2,
        'preview_id': 3,
        'medical_analysis_path': 'https://x.test/blood.pdf',
        'analysis_type': 'Blood',
      });

      expect(byCategory.category, 'Urine');
      expect(byType.category, 'Blood');
    });

    test('defaults category to empty when absent', () {
      final model = MedicalAnalysisModel.fromJson({
        'id': 2,
        'preview_id': 3,
        'medical_analysis_path': 'https://x.test/a.pdf',
      });
      expect(model.category, '');
    });

    test('leaves fileUrl empty when no recognised key is present', () {
      final model = MedicalAnalysisModel.fromJson({'id': 1});
      expect(model.fileUrl, '');
    });
  });

  group('MedicalAnalysisModel.displayName', () {
    test('derives a filename from a full URL', () {
      final model = const MedicalAnalysisModel(
        id: 1,
        previewId: 2,
        fileUrl: 'https://api.example.com/medical_analyses/report.pdf',
      );
      expect(model.displayName, 'report.pdf');
    });

    test('falls back to a stable label for an empty URL', () {
      final model = const MedicalAnalysisModel(id: 1, previewId: 2, fileUrl: '');
      expect(model.displayName, 'Medical Analysis');
    });

    test('falls back to a stable label for a trailing-slash URL', () {
      final model = const MedicalAnalysisModel(
        id: 1,
        previewId: 2,
        fileUrl: 'https://api.example.com/medical_analyses/',
      );
      expect(model.displayName, 'Medical Analysis');
    });
  });
}