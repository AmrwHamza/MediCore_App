import 'package:medicore_app/features/appointments/data/models/patient_appointment_info_model.dart';
import 'package:medicore_app/features/appointments/domain/entities/patient_appointment_entity.dart';

import 'appointment_types.dart';

class PatientAppointmentModel extends PatientAppointmentEntity {
  PatientAppointmentModel({
    required super.id,
    required super.patientId,
    required super.doctorId,
    required super.departmentId,
    required super.appointmentDate,
    required super.appointmentStatus,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    required super.appointmentInfo,
    required super.isChild,
  });

  factory PatientAppointmentModel.fromJson(
    Map<String, dynamic> json, {
    required bool isChild,
  }) {
    return PatientAppointmentModel(
      id: json['id'],
      patientId: json['patient_id'],
      doctorId: json['doctor_id'],
      departmentId: json['department_id'],
      appointmentDate: DateTime.parse(json['apointment_date']),
      appointmentStatus: json['apoitment_status'],
      status: fromStringToAppointmentTypes(json['status']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      appointmentInfo: PatientAppointmentInfoModel.fromJson(
        json['appointment_info'],
      ),
      isChild: isChild,
    );
  }
}
