import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/helper_function/get_it_service.dart';
import '../../../data/repos/edit_profile_repo_impl.dart';

part 'change_password_cubit.freezed.dart';
part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(const ChangePasswordState.initial());

  String? passwordValidator(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'empty_validate'.tr();
    }
    if (val.length < 8) {
      return 'password_too_short'.tr();
    }
    return null;
  }

  String? confirmPasswordValidator(String? val, String password) {
    if (val == null || val.trim().isEmpty) {
      return 'empty_validate'.tr();
    }
    if (val != password) {
      return 'password_mismatch'.tr();
    }
    return null;
  }

  Future<void> changePassword({
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    emit(const ChangePasswordState.loading());
    final result = await getIt<EditProfileRepoImpl>().changePassword(
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );
    result.fold(
      (failure) {
        emit(ChangePasswordState.failure(failure.message));
      },
      (messageSuccess) {
        emit(ChangePasswordState.success(messageSuccess));
      },
    );
  }
}
