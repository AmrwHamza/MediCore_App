import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/helper_function/user_information.dart';

part 'profile_header_info_cubit.freezed.dart';
part 'profile_header_info_state.dart';

class ProfileHeaderInfoCubit extends Cubit<ProfileHeaderInfoState> {
  ProfileHeaderInfoCubit() : super(const ProfileHeaderInfoState.initial());

  Future<void> getProfileHeaderInfo() async {
    emit(const ProfileHeaderInfoState.getProfileHeaderInfoLoading());
    try {
      final name = await getFullName();
      final email = await getUserEmail();
      emit(
        ProfileHeaderInfoState.getProfileHeaderInfoSuccess(
          name: name,
          email: email,
        ),
      );
    } catch (e) {
      emit(
        ProfileHeaderInfoState.getProfileHeaderInfoFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
