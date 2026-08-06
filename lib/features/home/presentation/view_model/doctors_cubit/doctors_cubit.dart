import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/home/data/repos/home_repo_impl.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_entity.dart';

part 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  DoctorsCubit() : super(DoctorsInitial());

  Future<void> getDoctors() async {
    emit(DoctorsLoading());
    final response = await getIt<HomeRepoImpl>().getDoctors();
    await response.fold(
      (failure) async {
        final cached = await getIt<HomeRepoImpl>().getCachedDoctors();
        cached.fold(
          (cacheFailure) => emit(DoctorsFailure(error: failure.message)),
          (doctors) {
            if (doctors.isEmpty) {
              emit(DoctorsFailure(error: failure.message));
            } else {
              emit(DoctorsSuccess(doctors));
            }
          },
        );
      },
      (data) async => emit(DoctorsSuccess(data)),
    );
  }
}
