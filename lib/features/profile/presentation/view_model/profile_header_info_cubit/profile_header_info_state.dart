part of 'profile_header_info_cubit.dart';

@freezed
class ProfileHeaderInfoState with _$ProfileHeaderInfoState {
  const factory ProfileHeaderInfoState.initial() = _Initial;
  const factory ProfileHeaderInfoState.getProfileHeaderInfoLoading() =
      _GetProfileHeaderInfoLoading;
  const factory ProfileHeaderInfoState.getProfileHeaderInfoFailure({
    required String errorMessage,
  }) = _GetProfileHeaderInfoFailure;
  const factory ProfileHeaderInfoState.getProfileHeaderInfoSuccess({
    required String name,
    required String email,
  }) = _GetProfileHeaderInfoSuccessSuccess;
}
