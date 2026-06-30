import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_entity.dart';

import '../../../../core/helper/shared_pref.dart';
import '../../../../core/helper_function/get_it_service.dart';
import '../../../../core/utils/api_services.dart';
import '../../../home/data/models/doctor_model.dart';
import '../../../home/data/models/hive/hive_home_local_storge.dart';
import '../../domain/repos/doctors_view_repo.dart';
import '../models/search_doctor_model.dart';

class DoctorsViewRepoImpl implements DoctorsViewRepo {
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
  Future<Either<Failure, List<DoctorEntity>>> searchDoctors({
    required String query,
  }) async {
    final response = await getIt<Api>().postWithAuth(
      endPoint: 'searchDoctors',
      data: {'query': query, 'lang': getIt<SharedPrefHelper>().languageCode},
    );

    return response.fold((failure) => Left(failure), (data) async {
      final doctorResponse = SearchDoctorModelBaseResponse.fromJson(data);
      await getIt<HiveHomeLocalStorge>().cacheDoctors(doctorResponse.doctors);
      return Right(doctorResponse.doctors);
    });
  }
}
