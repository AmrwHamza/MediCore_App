import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/onboarding_medical_info/data/models/child_model.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/childs_entity.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/get_child_entity.dart';

import '../../../appointments/data/models/privew_model.dart';
import '../../../appointments/domain/entities/privew_entity.dart';

class FamilyRepo {
  Future<Either<Failure, ChildsEntity>> getChilds() async {
    final response = await getIt<Api>().getWithAuth(endPoint: 'getChilds');
    return response.fold((failure) => Left(failure), (data) {
      final childs = ChildsModel.fromJson(data);
      return Right(childs);
    });
  }

  Future<Either<Failure, PrivewEntity>> getChildAppointment({
    required int patientId,
  }) async {
    final response = await getIt<Api>().getWithAuth(
      endPoint: 'getAppointmentById/$patientId',
    );
    return response.fold((failure) => Left(failure), (data) {
      final childs = PrivewModel.fromJson(data, isChild: true);
      return Right(childs);
    });
  }

  Future<Either<Failure, List<PrivewEntity>>> getChildPreviews({
    required num patientId,
  }) async {
    final response = await getIt<Api>().getWithAuth(endPoint: 'getPreviews');
    return response.fold((failure) => Left(failure), (data) {
      final privews = PrivewResponseModel.fromJson(data);
      final childPreviews = <PrivewEntity>[
        ...privews.completeSons,
        ...privews.partlyPreviewsSons,
      ];
      return Right(
        childPreviews.where((e) => e.patientId == patientId).toList(),
      );
    });
  }

  Future<Either<Failure, GetChildEntity>> updateChild({
    required int childId,
    required String firstName,
    required String lastName,
    required String birthDate,
    required String gender,
    required int age,
    required String bloodType,
  }) async {
    final response = await getIt<Api>().putWithAuth(
      endPoint: 'updateChild/$childId',
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'birth_date': birthDate,
        'gender': gender,
        'age': age,
        'blood_type': bloodType,
      },
    );
    return response.fold((failure) => Left(failure), (data) {
      final raw = data['data'] is Map
          ? Map<String, dynamic>.from(data['data'] as Map)
          : data;
      return Right(GetChildEntity.fromJson(raw));
    });
  }
}
