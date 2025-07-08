import 'package:medicore_app/features/home/domain/entities/doctor_entity.dart';

class DoctorResponseEntity {
  final String message;
  final List<DoctorEntity> doctors;

  DoctorResponseEntity({required this.message, required this.doctors});
}
