import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/home/domain/entities/department_entity.dart';

import '../../../../core/helper/shared_pref.dart';
import '../../../../core/helper_function/get_it_service.dart';
import '../../../../core/utils/api_services.dart';
import '../../../home/data/models/department_model.dart';
import '../../../home/data/models/hive/hive_home_local_storge.dart';
import '../../domain/repos/departments_view_repo.dart';
import '../models/search_department_model.dart';

class DepartmentsViewRepoImpl implements DepartmentsViewRepo {
  @override
  Future<Either<Failure, List<DepartmentEntity>>> getDepartment() async {
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
      return Left(UnknownFailure(message: '${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<DepartmentEntity>>> searchDepartment({
    required String query,
  }) async {
    final response = await getIt<Api>().postWithAuth(
      endPoint: 'searchDepartments',
      data: {'query': query, 'lang': getIt<SharedPrefHelper>().languageCode},
    );

    return response.fold((failure) => Left(failure), (data) async {
      final doctorResponse = SearchDepartmentModel.fromJson(data);
      await getIt<HiveHomeLocalStorge>().cacheDepartments(
        doctorResponse.departments,
      );
      return Right(doctorResponse.departments);
    });
  }
}
