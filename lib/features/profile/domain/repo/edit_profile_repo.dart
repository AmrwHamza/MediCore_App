import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';
import '../entities/edit_profile_entity.dart';
import '../entities/patient_profile_entity.dart';

abstract class EditProfileRepo {
  Future<Either<Failure, EditProfileEntity>> getProfileInfo();
  Future<Either<Failure, PatientProfileEntity>> getPatientProfileInfo();
  Future<Either<Failure, EditProfileEntity>> updateProfileInfo({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  });
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
  });

  Future<Either<Failure, String>> changePassword({
     required String newPassword,
    required String confirmNewPassword,
  });
}
