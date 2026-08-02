import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/features/onboarding_medical_info/data/repo/medical_repo.dart';

import '../../../../../core/helper_function/get_it_service.dart';

part 'patient_info_state.dart';

class PatientInfoCubit extends Cubit<PatientInfoState> {
  PatientInfoCubit() : super(PatientInfoInitial());

  Future<void> addPatientInfo({
    required String birthDate,
    required String gender,
    required int age,
    required String bloodType,
    required String chronicDiseases,
    required String allergyController,
    required String permanentMedications,
    required String previousSurgeries,
    required String previousIllnesses,
  }) async {
    emit(AddPatientInfoLoading());
    final data = {
      'birth_date': birthDate,
      'gender': gender,
      'age': age,
      'blood_type': bloodType,
      'chronic_diseases': chronicDiseases,
      'medical_allergies': allergyController,
      'permanent_medications': permanentMedications,
      'previous_surgeries': previousSurgeries,
      'previous_illnesses': previousIllnesses,
    };

    final result = await MedicalRepo().addPatientInfo(data);
    result.fold(
      (failure) => emit(AddPatientInfoFailure(error: failure.message)),
      (data) async {
        getIt<SharedPrefHelper>().setPatientProfileInfo(
          birthDate: birthDate,
          age: age,
          bloodType: bloodType,
          chronicDiseases: chronicDiseases,
          gender: gender,
          medicationAllergies: permanentMedications,
          permanentMedications: permanentMedications,
          previousIllnesses: previousIllnesses,
          previousSurgeries: previousSurgeries,
        );
        emit(AddPatientInfoSuccess(message: data.message));
      },
    );
  }
}
