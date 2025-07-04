import 'package:medicore_app/features/appointments/domain/entities/appointments_data_entity.dart';

class AppointmentsEntity {
  final String message;
  final AppointmentsDataEntity data;

  AppointmentsEntity({
    required this.message,
    required this.data,
  });
}
