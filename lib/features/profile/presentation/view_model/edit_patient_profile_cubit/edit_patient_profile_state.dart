part of 'edit_patient_profile_cubit.dart';

@freezed
class EditPatientProfileState with _$EditPatientProfileState {
  const factory EditPatientProfileState.initial() = _Initial;
  const factory EditPatientProfileState.loading() = _Loading;
  const factory EditPatientProfileState.success(
    PatientProfileEntity patientProfileInfo,
  ) = _Success;
  const factory EditPatientProfileState.editSuccess(
    PatientProfileEntity patientProfileInfo,
  ) = _EditSuccess;
  const factory EditPatientProfileState.failure(String message) = _Failure;
}
