import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/home/data/models/department_model.dart';
import 'package:medicore_app/features/home/data/models/doctor_info_model.dart';
import 'package:medicore_app/features/home/data/models/doctor_model.dart';
import 'package:medicore_app/features/home/data/models/hive/hive_home_local_storge.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_info_entity/doctor_info_entity.dart';

import '../../domain/entities/department_entity.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  HomeRepoImpl();

  @override
  Future<Either<Failure, List<DepartmentEntity>>> getDepartments() async {
    try {
      final response = await getIt<Api>().getWithAuth(endPoint: "department");
      return response.fold((failure) => Left(failure), (data) async {
        final departmentResponse = DepartmentResponseModel.fromJson(data);
        await getIt<HiveHomeLocalStorge>().cacheDepartments(
          departmentResponse.departments,
        );
        return Right(departmentResponse.departments);
      });
    } catch (e) {
      return Left(UnknownFailure('${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<DepartmentEntity>>> getCachedDepartments() async {
    try {
      final departments =
          await getIt<HiveHomeLocalStorge>().getCachedDepartments();
      return Right(departments);
    } catch (e) {
      return const Left(UnknownFailure("Faield to get cached departments "));
    }
  }

  @override
  Future<Either<Failure, DoctorInfoEntity>> getDoctorInfo(int doctorId) async {
    final response = await getIt<Api>().getWithAuth(
      endPoint: 'doctor/$doctorId',
    );

    return response.fold((failure) => Left(failure), (data) async {
      final doctorInfo = DoctorInfoModel.fromJson(data);
      return Right(doctorInfo);
    });
  }

  @override
  Future<Either<Failure, List<DoctorEntity>>> getDoctors() async {
    final response = await getIt<Api>().getWithAuth(endPoint: 'doctor');

    return response.fold((failure) => Left(failure), (data) async {
      final doctorResponse = DoctorResponseModel.fromJson(data);
      await getIt<HiveHomeLocalStorge>().cacheDoctors(doctorResponse.doctors);
      return Right(doctorResponse.doctors);
    });
  }

  @override
  Future<Either<Failure, List<DoctorEntity>>> getDoctorsInDepartment(
    int departmentId,
  ) async {
    final response = await getIt<Api>().getWithAuth(
      endPoint: 'department/doctor/$departmentId',
    );
    return response.fold((failure) => Left(failure), (data) async {
      final doctorResponse = DoctorResponseModel.fromJson(data);
      return Right(doctorResponse.doctors);
    });
  }
}
