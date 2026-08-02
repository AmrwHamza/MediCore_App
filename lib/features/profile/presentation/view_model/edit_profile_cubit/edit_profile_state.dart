part of 'edit_profile_cubit.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState.initial() = _Initial;
  const factory EditProfileState.loading() = _Loading;
  const factory EditProfileState.success(EditProfileEntity profileInfo) =
      _Success;
  const factory EditProfileState.EditSuccess(EditProfileEntity profileInfo) =
      _EditSuccess;
  const factory EditProfileState.error(String message) = _Error;
}
