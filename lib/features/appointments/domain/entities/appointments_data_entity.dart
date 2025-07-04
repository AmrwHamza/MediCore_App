import 'package:medicore_app/features/appointments/domain/entities/patient_appointment_entity.dart';

class AppointmentsDataEntity {
  final List<PatientAppointmentEntity> acceptedPatient;
  final List<PatientAppointmentEntity> waitingPatient;
final List<List<PatientAppointmentEntity>> acceptedSons;
final List<List<PatientAppointmentEntity>> waitingSons;


  AppointmentsDataEntity({
    required this.acceptedPatient,
    required this.waitingPatient,
    required this.acceptedSons,
    required this.waitingSons,
  });
}

