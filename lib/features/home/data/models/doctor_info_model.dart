import 'package:medicore_app/features/home/domain/entities/doctor_info_entity/doctor_info_entity.dart';

class DoctorInfoModel extends DoctorInfoEntity {
  DoctorInfoModel({
    required super.doctorId,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phone,
    required super.imagePath,
    required super.department,
    required super.rate,
  });

  factory DoctorInfoModel.fromJson(Map<String, dynamic> json) {
    final doctor = json['data']?['doctor'] ?? {};
    final user = doctor['user'] ?? {};
    final department = doctor['department'] ?? {};

    return DoctorInfoModel(
      doctorId: user['id'] ?? 0,
      firstName: user['first_name'] ?? '',
      lastName: user['last_name'] ?? '',
      email: user['email'] ?? '',
      phone: user['phone'] ?? '',
      imagePath: user['img_path'] ?? '',
      department: department['name'] ?? '',
      rate: doctor['average_rating'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': doctorId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'img_path': imagePath,
      'department_name': department,
      'rate': rate,
    };
  }
}
