import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  bool obscureOldPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  String oldPassword = '';
  String newPassword = '';
  String confirmPassword = '';

  void changeObscureOldPassword() {
    obscureOldPassword = !obscureOldPassword;
    emit(ChangeOldPasswordObscure(obscureOldPassword));
  }

  void changeObscureNewPassword() {
    obscureNewPassword = !obscureNewPassword;
    emit(ChangeNewPasswordObscure(obscureNewPassword));
  }

  void changeObscureConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    emit(ChangeConfirmPasswordObscure(obscureConfirmPassword));
  }

  String? validateOldPassword(String? val) {
    if (val == null || val.length < 8) {
      return 'password_too_short'.tr();
    }
    return null;
  }

  String? validateNewPassword(String? val) {
    if (val == null || val.length < 8) {
      return 'password_too_short'.tr();
    }
    return null;
  }

  String? validatePasswordMatch(String? val) {
    if (val != newPassword) {
      return 'passwords_do_not_match'.tr();
    }
    return null;
  }
}
