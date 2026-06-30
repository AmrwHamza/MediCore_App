import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../../../core/helper_function/get_it_service.dart';
import '../../../data/repo/drawer_repo_impl.dart';

part 'profile_image_state.dart';

class ProfileImageCubit extends Cubit<ProfileImageState> {
  ProfileImageCubit() : super(ProfileImageInitial());

  static const String _cacheBoxName = 'profile_image_box';
  static const String _cacheKey = 'cached_image_path';

  Future<void> getProfileImage({bool forceRefresh = false}) async {
    final box = await Hive.openBox(_cacheBoxName);
    final cachedPath = box.get(_cacheKey) as String?;

    if (cachedPath != null && !forceRefresh) {
      if (cachedPath.isEmpty) {
        emit(ProfileImageEmpty());
      } else {
        emit(GetProfileImageSuccess(profileImagePath: cachedPath));
      }
      return;
    }

    emit(ProfileImageLoading());

    final response = await getIt<DrawerRepoImpl>().getProfileImage();

    response.fold(
      (failure) {
        if (failure.statusCode == 400) {
          emit(ProfileImageEmpty());
        } else {
          emit(ProfileImageFailure(errorMessage: failure.message));
        }
      },
      (data) async {
        if (data == null || data.isEmpty) {
          await box.put(_cacheKey, '');
          emit(ProfileImageEmpty());
        } else {
          await box.put(_cacheKey, data);
          emit(GetProfileImageSuccess(profileImagePath: data));
        }
      },
    );
  }

  Future<void> addProfileImage({required File image}) async {
    emit(ProfileImageLoading());

    final response = await getIt<DrawerRepoImpl>().addProfileImage(
      image: image,
    );

    response.fold(
      (failure) {
        emit(ProfileImageFailure(errorMessage: failure.message));
      },
      (data) async {
        final box = await Hive.openBox(_cacheBoxName);
        await box.put(_cacheKey, data);
        emit(
          AddProfileImageSuccess(
            message: 'add_profile_image_success'.tr(),
            profileImagePath: data,
          ),
        );
      },
    );
  }

  Future<void> deleteProfileImage() async {
    emit(ProfileImageLoading());

    final response = await getIt<DrawerRepoImpl>().deleteProfileImage();

    response.fold(
      (failure) {
        emit(ProfileImageFailure(errorMessage: failure.message));
      },
      (data) async {
        final box = await Hive.openBox(_cacheBoxName);
        await box.put(_cacheKey, '');
        emit(
          DeleteProfileImageSuccess(
            message: 'delete_profile_image_success'.tr(),
          ),
        );
      },
    );
  }
}
