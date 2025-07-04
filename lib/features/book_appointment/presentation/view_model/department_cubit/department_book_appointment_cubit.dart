import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/home/data/repos/home_repo_impl.dart';
import 'package:medicore_app/features/home/domain/entities/department_entity.dart';

part 'department_book_appointment_state.dart';

class DepartmentBookAppointmentCubit extends Cubit<DepartmentBookAppointmentState> {
  DepartmentBookAppointmentCubit() : super(DepartmentBookAppointmentInitial());

  Future<void> getDepartments(bui) async {
    emit(DepartmentsLoading());
    final response = await getIt<HomeRepoImpl>().getDepartments();
    response.fold(
      (failure) => emit(GetDepartmentFailure(error: failure.message)),
      (data) => emit(GetDepartmentsSuccess(departments: data)),
    );
  }
}
