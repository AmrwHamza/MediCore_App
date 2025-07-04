import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

part 'edit_profile_info_state.dart';

class EditProfileInfoCubit extends Cubit<EditProfileInfoState> {
  EditProfileInfoCubit() : super(EditProfileInfoInitial());

  String firstName = '';
  String lastName = '';
  String email = '';
  String phone = '';

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

  String? validatePhone(String? val) {
    if (val == null || val.length != 9) {
      return 'invalid_phone'.tr();
    }
    return null;
  }
}
