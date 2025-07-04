import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/features/onboarding_medical_info/data/repo/medical_repo.dart';

part 'patient_info_state.dart';

class PatientInfoCubit extends Cubit<PatientInfoState> {
  PatientInfoCubit() : super(PatientInfoInitial());

  Future<void> addPatientInfo(Map<String, dynamic> data) async {
    emit(AddPatientInfoLoading());
    final result = await MedicalRepo().addPatientInfo(data);
    result.fold(
      (failure) => emit(AddPatientInfoFailure(error: failure.message)),
      (data) => emit(AddPatientInfoSuccess(message: data.message)),
    );
  }
}
