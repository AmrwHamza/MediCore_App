import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/home/data/repos/home_repo_impl.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_info_entity/doctor_info_entity.dart';

part 'doctor_info_state.dart';

class DoctorInfoCubit extends Cubit<DoctorInfoState> {
  DoctorInfoCubit() : super(DoctorInfoInitial());

  Future<void> getDoctorInfo(int DoctorId) async {
    emit(DoctorInfoLoading());
    final response = await getIt<HomeRepoImpl>().getDoctorInfo(DoctorId);
    response.fold(
      (failure) => emit(DoctorInfoFailure(error: failure.message)),
      (data) => emit(DoctorInfoSuccess(doctorInfo: data)),
    );
  }
}
