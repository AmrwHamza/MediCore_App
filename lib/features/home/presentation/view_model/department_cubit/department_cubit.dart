import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/home/data/repos/home_repo_impl.dart';
import 'package:medicore_app/features/home/domain/entities/department_entity.dart';

part 'department_state.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentCubit() : super(DepartmentInitial());

  Future<void> getDepartments(BuildContext context) async {
    emit(DepartmentLoading());
    
    final response = await getIt<HomeRepoImpl>().getDepartments();
    response.fold(
      (failure) =>
          emit(DepartmentFailure(error: 'get_department_failure'.tr())),
      (data) => emit(DepartmentSuccess(departments: data)),
    );
  }
}
