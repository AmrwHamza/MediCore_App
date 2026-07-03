import 'package:easy_localization/easy_localization.dart';

import '../../domain/entities/patient_appointment_entity.dart';
import '../../domain/entities/privew_entity.dart';
import '../models/appointment_types.dart';

class AppointmentMapper {
  static PrivewEntity fromPrivewToAppointment(
    PatientAppointmentEntity appointment,
  ) {
    return PrivewEntity(
      id: appointment.id,
      patientId: appointment.patientId,
      doctorId: appointment.doctorId,
      departmentId: appointment.departmentId,
      date: DateFormat.yMMMd().format(appointment.appointmentDate),
      status: fromAppointmentTypesToApiString(appointment.status),
      createdAt: DateFormat.yMMMd().format(appointment.createdAt),
      updatedAt: DateFormat.yMMMd().format(appointment.updatedAt),
      doctorName: appointment.appointmentInfo.doctorName,
      gender: appointment.appointmentInfo.gender,
      imgPath: appointment.appointmentInfo.patientImage ?? '',
      patientName: appointment.appointmentInfo.patientName,
      isChild: appointment.isChild,
      //////////
      medicine: '',
      notes: '',
      diagnoseis: '',
      diagnoseisType: 0,
      price: 0,
      appointmentId: 0
    );
  }
}
