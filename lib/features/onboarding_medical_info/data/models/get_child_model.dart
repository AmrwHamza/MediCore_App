import 'package:medicore_app/features/onboarding_medical_info/domain/entities/get_child_entity.dart';

class GetChildModel extends GetChildEntity {
  GetChildModel({
    required super.id,
    required super.patientId,
    required super.firstName,
    required super.lastName,
    required super.gender,
    required super.age,
    required super.birthDate,
  });

  factory GetChildModel.fromJson(Map<String, dynamic> json) {
    final patientInfo = json['patient_info'];
    return GetChildModel(
      id: json['id'],
      patientId: json['patient_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: patientInfo['gender'],
      age: patientInfo['age'],
      birthDate: patientInfo['birth_date'],
    );
  }
}
