import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/helper/shared_pref.dart';
import '../../../../../core/helper_function/get_it_service.dart';
import '../../../data/repos/edit_profile_repo_impl.dart';
import '../../../domain/entities/edit_profile_entity.dart';

part 'edit_profile_cubit.freezed.dart';
part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(const EditProfileState.initial());

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

  Future<void> getProfileInfo() async {
    emit(const EditProfileState.loading());
    final result = await getIt<EditProfileRepoImpl>().getProfileInfo();
    result.fold(
      (failure) {
        emit(EditProfileState.error(failure.message));
      },
      (profile) {
        emit(EditProfileState.success(profile));
      },
    );
  }

  Future<void> updateProfileInfo({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    emit(const EditProfileState.loading());
    final result = await getIt<EditProfileRepoImpl>().updateProfileInfo(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );

    result.fold(
      (failure) {
        emit(EditProfileState.error(failure.message));
      },
      (profile) async {
        await saveInfo(firstName, lastName, email, phone);
        
        emit(EditProfileState.EditSuccess(profile));
      },
    );
  }

  Future<void> saveInfo(
    String firstName,
    String lastName,
    String email,
    String phone,
  ) async {
    await getIt<SharedPrefHelper>().setProfileInfo(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );
  }
}
