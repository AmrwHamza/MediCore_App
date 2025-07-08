import 'package:medicore_app/features/home/domain/entities/department_entity.dart';
import 'package:medicore_app/features/home/domain/entities/department_response_entity.dart';

class DepartmentResponseModel extends DepartmentResponseEntity {
  DepartmentResponseModel({required super.message, required super.departments});

  factory DepartmentResponseModel.fromJson(Map<String, dynamic> json) {
    final departmentJson = json['data']['departments'] as List;

    return DepartmentResponseModel(
      message: json['msg'],
      departments:
          departmentJson.map((item) => DepartmentModel.fromJson(item)).toList(),
    );
  }
}

class DepartmentModel extends DepartmentEntity {
  DepartmentModel({
    required super.id,
    required super.departmentName,
    required super.description,
    required super.image,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'],
      departmentName: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}
