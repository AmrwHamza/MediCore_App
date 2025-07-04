import 'package:hive/hive.dart';

part 'hive_appointments_model.g.dart';

@HiveType(typeId: 0)
class HiveAppointmentModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int patientId;

  @HiveField(2)
  int doctorId;

  @HiveField(3)
  int departmentId;

  @HiveField(4)
  DateTime appointmentDate;

  @HiveField(5)
  String appointmentStatus;

  @HiveField(6)
  String status;

  @HiveField(7)
  int enter;

  @HiveField(8)
  DateTime createdAt;

  @HiveField(9)
  DateTime updatedAt;

  HiveAppointmentModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.departmentId,
    required this.appointmentDate,
    required this.appointmentStatus,
    required this.status,
    required this.enter,
    required this.createdAt,
    required this.updatedAt,
  });
}
