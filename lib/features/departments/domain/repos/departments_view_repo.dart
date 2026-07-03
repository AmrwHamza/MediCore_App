import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';
import '../../../home/domain/entities/department_entity.dart';

abstract class DepartmentsViewRepo {
  Future<Either<Failure, List<DepartmentEntity>>> getDepartment();
  Future<Either<Failure, List<DepartmentEntity>>> searchDepartment({
    required String query,
  });
}
