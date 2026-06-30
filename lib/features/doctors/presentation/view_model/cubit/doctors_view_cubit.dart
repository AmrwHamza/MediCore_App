import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/helper_function/get_it_service.dart';
import '../../../../home/domain/entities/doctor_entity.dart';
import '../../../data/repos/doctors_view_repo_impl.dart';

part 'doctors_view_state.dart';

class DoctorsViewCubit extends Cubit<DoctorsViewState> {
  DoctorsViewCubit() : super(DoctorsViewInitial());

  Future<void> getDoctors() async {
    emit(DoctorsViewLoading());
    final response = await getIt<DoctorsViewRepoImpl>().getDoctors();
    response.fold(
      (l) => emit(DoctorsViewFailure(error: l.message)),
      (r) => emit(DoctorsViewSuccess(doctors: r)),
    );
  }

  Future<void> searchDoctors({required String query}) async {
    emit(DoctorsViewLoading());
    final response = await getIt<DoctorsViewRepoImpl>().searchDoctors(
      query: query,
    );
    response.fold(
      (l) => emit(DoctorsViewFailure(error: l.message)),
      (r) => emit(DoctorsViewSuccess(doctors: r)),
    );
  }
}
