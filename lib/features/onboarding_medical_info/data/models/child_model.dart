import 'package:medicore_app/features/onboarding_medical_info/data/models/get_child_model.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/child_entity.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/childs_entity.dart';

class ChildsModel extends ChildsEntity {
  ChildsModel({required super.childList, required super.message});

  factory ChildsModel.fromJson(Map<String, dynamic> json) {
    return ChildsModel(
      childList:
          (json['data'] as List).map((e) => GetChildModel.fromJson(e)).toList(),
      message: json['message'],
    );
  }
}

class ChildModel extends ChildEntity {
  ChildModel({
    required super.message,
    required super.id,
    required super.patientId,
    required super.firstName,
    required super.lastName,
    required super.gender,
    required super.age,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final patientInfo = data['patient_info'];
    return ChildModel(
      message: json['message'] ?? '',
      id: data['id'],
      patientId: data['patient_id'],
      firstName: data['first_name'],
      lastName: data['last_name'],
      gender: patientInfo['gender'],
      age: patientInfo['age'],
    );
  }
}
