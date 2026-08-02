import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/helper/shared_pref.dart';
import '../../../../../core/helper_function/get_it_service.dart';
import '../../../../../core/utils/logger_helper.dart';
import '../../../data/repos/edit_profile_repo_impl.dart';
import '../../../domain/entities/patient_profile_entity.dart';

part 'edit_patient_profile_cubit.freezed.dart';
part 'edit_patient_profile_state.dart';

class EditPatientProfileCubit extends Cubit<EditPatientProfileState> {
  EditPatientProfileCubit() : super(const EditPatientProfileState.initial());

  Future<void> getPatientProfileInfo() async {
    emit(const EditPatientProfileState.loading());
    final result = await getIt<EditProfileRepoImpl>().getPatientProfileInfo();
    result.fold(
      (failure) {
        emit(EditPatientProfileState.failure(failure.message));
      },
      (profile) {
        LoggerHelper.info('😂😂Profile = ${profile.toString()}');
        emit(EditPatientProfileState.success(profile));
      },
    );
  }

  Future<void> updatePatientProfileInfo({
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
    emit(const EditPatientProfileState.loading());
    final result = await getIt<EditProfileRepoImpl>().updatePatientProfileInfo(
      birthDate: birthDate,
      gender: gender,
      age: age,
      bloodType: bloodType,
      medicationAllergies: medicationAllergies,
      chronicDiseases: chronicDiseases,
      permanentMedications: permanentMedications,
      previousSurgeries: previousSurgeries,
      previousIllnesses: previousIllnesses,
    );

    result.fold(
      (failure) {
        emit(EditPatientProfileState.failure(failure.message));
      },
      (profile) async {
        await saveInfo(
          birthDate,
          gender,
          age,
          bloodType,
          medicationAllergies,
          chronicDiseases,
          permanentMedications,
          previousSurgeries,
          previousIllnesses,
        );
        emit(EditPatientProfileState.editSuccess(profile));
      },
    );
  }

  Future<void> saveInfo(
    String? birthDate,
    String? gender,
    String? age,
    String? bloodType,
    String? medicationAllergies,
    String? chronicDiseases,
    String? permanentMedications,
    String? previousSurgeries,
    String? previousIllnesses,
  ) async {
    await getIt<SharedPrefHelper>().setPatientProfileInfo(
      birthDate: birthDate,
      gender: gender,
      age: int.parse(age!),
      bloodType: bloodType,
      medicationAllergies: medicationAllergies,
      chronicDiseases: chronicDiseases,
      permanentMedications: permanentMedications,
      previousSurgeries: previousSurgeries,
      previousIllnesses: previousIllnesses,
    );
  }
}
