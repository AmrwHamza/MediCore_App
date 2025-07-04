import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/home/domain/entities/department_entity.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_info_entity/doctor_info_entity.dart';

import '../entities/doctor_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<DepartmentEntity>>> getDepartments();
  Future<Either<Failure, List<DepartmentEntity>>> getCachedDepartments();
  Future<Either<Failure, List<DoctorEntity>>> getDoctors();
  Future<Either<Failure, DoctorInfoEntity>> getDoctorInfo(int id);
  Future<Either<Failure, List<DoctorEntity>>> getDoctorsInDepartment(int id);
}
