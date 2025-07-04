import 'package:medicore_app/features/home/domain/entities/doctor_department_entity.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_user_entity.dart';

class DoctorEntity {
  final int doctorId;
  final int departmentId;
  final int userId;
  final String bio;
  final double? rate;
  final DoctorDepartmentEntity? department;
  final DoctorUserEntity user;

  DoctorEntity( {
    required this.doctorId,
    required this.departmentId,
    required this.userId,
    required this.bio,
    required this.department,
    required this.user,
    this.rate,
  });
}
