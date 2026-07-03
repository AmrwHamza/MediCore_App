part of 'doctors_view_cubit.dart';

@freezed
class DoctorsViewState with _$DoctorsViewState {
  const factory DoctorsViewState.initial() = _Initial;
  const factory DoctorsViewState.getDoctorsLoading() = _GetDoctorsLoading;
  const factory DoctorsViewState.searchDoctorsLoading() = _SearchDoctorsLoading;
  const factory DoctorsViewState.getDoctorsFailure({
    required String errorMessage,
  }) = _GetDoctorsFailure;
  const factory DoctorsViewState.searchDoctorsFailure({
    required String errorMessage,
  }) = _SearchDoctorsFailure;
  const factory DoctorsViewState.getDoctorsSuccess({
    required List<DoctorEntity> doctors,
  }) = _GetDoctorsSuccess;
  const factory DoctorsViewState.searchDoctorsSuccess({
    required List<DoctorEntity> doctors,
  }) = _SearchDoctorsSuccess;
}
