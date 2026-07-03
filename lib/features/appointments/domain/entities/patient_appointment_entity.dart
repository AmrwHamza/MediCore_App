import 'package:medicore_app/features/appointments/domain/entities/patient_appointment_info_entity.dart';

import '../../data/models/appointment_types.dart';

class PatientAppointmentEntity {
  final int id;
  final int patientId;
  final int doctorId;
  final int departmentId;
  final DateTime appointmentDate;
  final String appointmentStatus;
  final AppointmentTypes status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PatientAppointmentInfoEntity appointmentInfo;
  final bool isChild;

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
    required this.isChild,
  });
}
