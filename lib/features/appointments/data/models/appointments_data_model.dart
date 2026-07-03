import 'package:medicore_app/features/appointments/domain/entities/appointments_data_entity.dart';

import 'patient_appointment_model.dart';

class AppointmentsDataModel extends AppointmentsDataEntity {
  AppointmentsDataModel({
    required super.acceptedPatient,
    required super.waitingPatient,
    required super.acceptedSons,
    required super.waitingSons,
  });

  factory AppointmentsDataModel.fromJson(Map<String, dynamic> json) {
    return AppointmentsDataModel(
      acceptedPatient:
          (json['accepted_patient'] as List)
              .map((e) => PatientAppointmentModel.fromJson(e,isChild:false))
              .toList(),
      waitingPatient:
          (json['waiting_patient'] as List)
              .map((e) => PatientAppointmentModel.fromJson(e,isChild:false))
              .toList(),
      acceptedSons:
          (json['accepted_sons'] as List)
              .map<List<PatientAppointmentModel>>(
                (e) =>
                    (e as List)
                        .map<PatientAppointmentModel>(
                          (item) => PatientAppointmentModel.fromJson(item,isChild:true),
                        )
                        .toList(),
              )
              .toList(),

      waitingSons:
          (json['waiting_sons'] as List)
              .map<List<PatientAppointmentModel>>(
                (e) =>
                    (e as List)
                        .map<PatientAppointmentModel>(
                          (item) => PatientAppointmentModel.fromJson(item,isChild:true),
                        )
                        .toList(),
              )
              .toList(),
    );
  }
}
