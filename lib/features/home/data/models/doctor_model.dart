import 'package:easy_localization/easy_localization.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_department_entity.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_entity.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_response_entity.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_user_entity.dart';

class DoctorResponseModel extends DoctorResponseEntity {
  DoctorResponseModel({required super.message, required super.doctors});

  factory DoctorResponseModel.fromJson(Map<String, dynamic> json) {
    final doctorsJson = json['data']['doctors'] as List;

    return DoctorResponseModel(
      message: json['msg'],
      doctors: doctorsJson.map((item) => DoctorModel.fromJson(item)).toList(),
    );
  }
}

class DoctorModel extends DoctorEntity {
  DoctorModel({
    required super.doctorId,
    super.rate,
    required super.departmentId,
    required super.userId,
    required super.bio,
    required super.department,
    required super.user,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    doctorId: json['id'],
    rate: (json['average_rating'] as num?)?.toDouble() ?? 0.0,

    departmentId: json['department_id'],
    userId: json['user_id'],
    bio: json['bio'],
    department:
        json['department'] != null
            ? DoctorDepartmentModel.fromJson(json['department'])
            : null,
    user: DoctorUserModel.fromJson(json['user']),
  );
}

class DoctorDepartmentModel extends DoctorDepartmentEntity {
  DoctorDepartmentModel({
    required super.departmentId,
    required super.name,
    required super.image,
  });

  factory DoctorDepartmentModel.fromJson(Map<String, dynamic> json) {
     final langCode = Intl.getCurrentLocale(); 
     final nameMap = json['name'];
     return DoctorDepartmentModel(
      departmentId: json['id'],
      name: nameMap[langCode] ?? nameMap['en'], 
      image: json['image'],
    );
  }
}

class DoctorUserModel extends DoctorUserEntity {
  DoctorUserModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phone,
    required super.imagePath,
    required super.experience,
  });

  factory DoctorUserModel.fromJson(Map<String, dynamic> json) =>
      DoctorUserModel(
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        phone: json['phone'],
        imagePath: json['img_path'] ?? '',
        experience: json['expire_at'] ?? '',
      );
}
