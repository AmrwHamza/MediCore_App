import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_validate_state.dart';

class AuthValidateCubit extends Cubit<AuthValidateState> {
  AuthValidateCubit() : super(AuthInitial());

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  String email = '';
  String password = '';
  String confirmPassword = '';
  String phone = '';

  void changeObscurePassword() {
    obscurePassword = !obscurePassword;
    emit(ChangePasswordObscure(obscurePassword));
  }

  void changeObscureConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    emit(ChangeConfirmPasswordObscure(obscureConfirmPassword));
  }

  String? validateName(String? val) {
    if (val == null) {
      return 'invalid_name'.tr();
    }
    return null;
  }

  String? validateEmail(String? val) {
    if (val == null || !val.contains('@')) {
      return 'invalid_email'.tr();
    }
    return null;
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
    if (val != password) {
      return 'passwords_do_not_match'.tr();
    }
    return null;
  }

  String? validatePhone(String? val) {
    if (val == null || val.length != 9) {
      return 'invalid_phone'.tr();
    }
    return null;
  }
}
