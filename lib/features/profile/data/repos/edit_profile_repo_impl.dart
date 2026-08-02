import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/profile/domain/entities/edit_profile_entity.dart';
import 'package:medicore_app/features/profile/domain/entities/patient_profile_entity.dart';

import '../../../../core/helper/shared_pref.dart';
import '../../../../core/helper_function/get_it_service.dart';
import '../../../../core/utils/api_services.dart';
import '../../domain/repo/edit_profile_repo.dart';
import '../models/edit_profile_model.dart';
import '../models/patient_profile_model.dart';

class EditProfileRepoImpl implements EditProfileRepo {
  @override
  Future<Either<Failure, EditProfileEntity>> updateProfileInfo({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    final response = await getIt<Api>().putWithAuth(
      endPoint: 'updateProfileInfo',
      queryParameters: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        "validate": 1,
      },
    );

    return response.fold(
      (failure) {
        return Left(failure);
      },
      (data) {
        final profile = EditProfileModel.fromJson(data);
        return Right(profile);
      },
    );
  }

  @override
  Future<Either<Failure, PatientProfileEntity>> updatePatientProfileInfo({
    required String? birthDate,
    required String? gender,
    required String? age,
    required String? bloodType,
    required String? medicationAllergies,
    required String? chronicDiseases,
    required String? permanentMedications,
    required String? previousSurgeries,
    required String? previousIllnesses,
  }) async {
    final response = await getIt<Api>().putWithAuth(
      endPoint: 'updatePatientProfile',
      queryParameters: {
        'birth_date': birthDate,
        'gender': gender,
        'age': age,
        'blood_type': bloodType,
        'medication_allergies': medicationAllergies,
        'chronic_diseases': chronicDiseases,
        'permanent_medications': permanentMedications,
        'previous_surgeries': previousSurgeries,
        'previous_illnesses': previousIllnesses,
      },
    );

    return response.fold(
      (failure) {
        return Left(failure);
      },
      (data) {
        final patientProfile = PatientProfileModel.fromJson(data['data']);
        return Right(patientProfile);
      },
    );
  }

  @override
  Future<Either<Failure, PatientProfileEntity>> getPatientProfileInfo() async {
    try {
      final response = getIt<SharedPrefHelper>().patientProfileInfo;
      final patientProfile = PatientProfileEntity(
        birthDate: response.birthDate,
        gender: response.gender,
        age: response.age,
        bloodType: response.bloodType,
        medicationAllergies: response.medicationAllergies,
        chronicDiseases: response.chronicDiseases,
        permanentMedications: response.permanentMedications,
        previousSurgeries: response.previousSurgeries,
        previousIllnesses: response.previousIllnesses,
      );
      return Right(patientProfile);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, EditProfileEntity>> getProfileInfo() async {
    try {
      final response = await getIt<SharedPrefHelper>().profileInfo;
      final profileInfo = EditProfileEntity(
        firstName: response.firstName,
        lastName: response.lastName,
        email: response.email,
        phone: response.phone,
      );
      return Right(profileInfo);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> changePassword({
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final response = await getIt<Api>().putWithAuth(
        endPoint: 'updatePassword',
        queryParameters: {
          "password": newPassword,
          "password_confirmation": confirmNewPassword,
          "validate": "0",
        },
      );
      return response.fold(
        (failure) => Left(failure),
        (data) => Right('change_password_success'.tr()),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
