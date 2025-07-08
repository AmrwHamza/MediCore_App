import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/home/data/repos/home_repo_impl.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_entity.dart';

part 'department_details_state.dart';

class DepartmentDetailsCubit extends Cubit<DepartmentDetailsState> {
  DepartmentDetailsCubit() : super(DepartmentDetailsInitial());

  Future<void> getDoctorsInDepartment(int departmentId) async {
    emit(DepartmentDetailsLoading());
    final response = await getIt<HomeRepoImpl>().getDoctorsInDepartment(
      departmentId,
    );
    response.fold(
      (failure) => emit(DepartmentDetailsFailure(error: failure.message)),
      (data) => emit(DepartmentDetailsSuccess(doctors: data)),
    );
  }
}
