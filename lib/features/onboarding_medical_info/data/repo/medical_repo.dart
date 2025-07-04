import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/onboarding_medical_info/data/models/child_model.dart';
import 'package:medicore_app/features/onboarding_medical_info/data/models/patient_info_model.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/child_entity.dart';

class MedicalRepo {
  MedicalRepo();

  Future<Either<Failure, PatientInfoModel>> addPatientInfo(
    Map<String, dynamic> data,
  ) async {
    final response = await getIt<Api>().postWithAuth(
      endPoint: 'pateintProfile',
      data: data,
    );
    return response.fold(
      (failure) => Left(failure),
      (data) => Right(PatientInfoModel.fromJson(data)),
    );
  }

  Future<Either<Failure, ChildEntity>> addChild(
    Map<String, dynamic> data,
  ) async {
    final response = await getIt<Api>().postWithAuth(
      endPoint: 'addChild',
      data: data,
    );
    return response.fold(
      (failure) => Left(failure),
      (data) => Right(ChildModel.fromJson(data)),
    );
  }

  Future<Either<Failure, String>> deleteChild(int id) async {
    final response = await getIt<Api>().deleteWithAuth(
      endPoint: 'deleteChild/$id',
      data: [],
    );
    return response.fold((failure) => Left(failure), (data) {
      return  Right('delete_child_success'.tr());
    });
  }
}
