import 'package:medicore_app/features/home/domain/entities/department_entity.dart';

class DepartmentResponseEntity {
  final String message;
  final List<DepartmentEntity> departments;

  DepartmentResponseEntity({required this.message, required this.departments});
}

