import 'package:flutter_test/flutter_test.dart';
import 'package:medicore_app/features/appointments/data/models/appointment_types.dart';
import 'package:medicore_app/features/appointments/domain/entities/privew_entity.dart';

PrivewEntity _preview({int type = 0, String status = 'incomplete'}) {
  return PrivewEntity(
    id: 1,
    patientId: 100,
    doctorId: 2,
    departmentId: 3,
    patientName: 'Patient',
    doctorName: 'Doctor',
    gender: 'male',
    imgPath: '',
    diagnoseis: '',
    medicine: '',
    notes: '',
    date: '2026-08-01',
    status: status,
    price: 0,
    createdAt: '2026-08-01',
    updatedAt: '2026-08-01',
    diagnoseisType: type,
    isChild: false,
    appointmentId: 5,
  );
}

void main() {
  group('isIncompleteDiagnosis', () {
    test('true for a partial diagnosis with an incomplete status', () {
      expect(isIncompleteDiagnosis(_preview(type: 0, status: 'incomplete')), isTrue);
    });

    test('true regardless of casing', () {
      expect(
        isIncompleteDiagnosis(_preview(type: 0, status: 'InComplete')),
        isTrue,
      );
    });

    test('true for other partial-diagnosis statuses', () {
      expect(isIncompleteDiagnosis(_preview(type: 0, status: 'partial')), isTrue);
      expect(
        isIncompleteDiagnosis(_preview(type: 0, status: 'in_progress')),
        isTrue,
      );
    });

    test('false for a waiting appointment with diagnoseisType 0', () {
      expect(isIncompleteDiagnosis(_preview(type: 0, status: 'waiting')), isFalse);
    });

    test('false for a pending appointment with diagnoseisType 0', () {
      expect(isIncompleteDiagnosis(_preview(type: 0, status: 'pending')), isFalse);
    });

    test('false for an accepted appointment with diagnoseisType 0', () {
      expect(
        isIncompleteDiagnosis(_preview(type: 0, status: 'accepted')),
        isFalse,
      );
    });

    test('false for a complete diagnosis (diagnoseisType 1)', () {
      expect(isIncompleteDiagnosis(_preview(type: 1, status: 'complete')), isFalse);
    });
  });

  group('isCompletedDiagnosis', () {
    test('true only for diagnoseisType 1', () {
      expect(isCompletedDiagnosis(_preview(type: 1, status: 'complete')), isTrue);
      expect(isCompletedDiagnosis(_preview(type: 0, status: 'incomplete')), isFalse);
    });
  });
}