import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/helper_function/get_it_service.dart';
import '../../../../home/domain/entities/department_entity.dart';
import '../../../data/repos/departments_view_repo_impl.dart';

part 'departments_view_cubit.freezed.dart';
part 'departments_view_state.dart';

class DepartmentsViewCubit extends Cubit<DepartmentsViewState> {
  DepartmentsViewCubit() : super(const DepartmentsViewState.initial());

  Timer? _debounce;

  Future<void> getDepartments() async {
    emit(const DepartmentsViewState.getDepartmentsLoading());
    final response = await getIt<DepartmentsViewRepoImpl>().getDepartment();
    response.fold(
      (l) => emit(
        DepartmentsViewState.getDepartmentsFailure(errorMessage: l.message),
      ),
      (r) => emit(DepartmentsViewState.getDepartmentsSuccess(departments: r)),
    );
  }

  void searchDepartments({required String query}) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.isEmpty) {
      getDepartments();
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(const DepartmentsViewState.searchDepartmentsLoading());
      final response = await getIt<DepartmentsViewRepoImpl>().searchDepartment(
        query: query,
      );
      response.fold(
        (l) => emit(
          DepartmentsViewState.searchDepartmentsFailure(
            errorMessage: l.message,
          ),
        ),
        (r) =>
            emit(DepartmentsViewState.searchDepartmentsSuccess(departments: r)),
      );
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
