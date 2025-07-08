import 'package:medicore_app/features/appointments/domain/entities/patient_appointment_info_entity.dart';

class PatientAppointmentInfoModel extends PatientAppointmentInfoEntity {
  PatientAppointmentInfoModel({
    required super.patientName,
    required super.patientImage,
    required super.doctorName, required super.gender,
  });

  factory PatientAppointmentInfoModel.fromJson(Map<String, dynamic> json) {
    return PatientAppointmentInfoModel(
      patientName: json['patientName'],
      patientImage: json['patientImage'],
      doctorName: json['doctorName'],
      gender: json['gender'],
    );
  }
}
