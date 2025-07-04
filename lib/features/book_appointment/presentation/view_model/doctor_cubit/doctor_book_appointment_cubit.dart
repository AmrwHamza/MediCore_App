import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/home/data/repos/home_repo_impl.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_entity.dart';

part 'doctor_book_appointment_state.dart';

class DoctorBookAppointmentCubit extends Cubit<DoctorBookAppointmentState> {
  DoctorBookAppointmentCubit() : super(DoctorBookAppointmentInitial());

  Future<void> getAllDoctors() async {
    emit(DoctorsLoading());
    final response = await getIt<HomeRepoImpl>().getDoctors();
    return response.fold(
      (failure) => emit(GetDoctorsInDepartmentFailure(error: failure.message)),
      (data) => emit(GetDoctorsInDepartmentSuccess(doctors: data)),
    );
  }

  Future<void> getDoctorsInDepartment(int departmentId) async {
    emit(DoctorsLoading());
    final response = await getIt<HomeRepoImpl>().getDoctorsInDepartment(
      departmentId,
    );
    response.fold(
      (failure) => emit(GetDoctorsInDepartmentFailure(error: failure.message)),
      (data) => emit(GetDoctorsInDepartmentSuccess(doctors: data)),
    );
  }
}
