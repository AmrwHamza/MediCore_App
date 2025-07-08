import 'package:medicore_app/features/appointments/domain/entities/patient_appointment_info_entity.dart';

class PatientAppointmentEntity {
  final int id;
  final int patientId;
  final int doctorId;
  final int departmentId;
  final DateTime appointmentDate;
  final String appointmentStatus;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PatientAppointmentInfoEntity appointmentInfo;

  PatientAppointmentEntity({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.departmentId,
    required this.appointmentDate,
    required this.appointmentStatus,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.appointmentInfo,
  });
}
