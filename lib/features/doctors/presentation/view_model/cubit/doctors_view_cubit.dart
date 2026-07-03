import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/helper_function/get_it_service.dart';
import '../../../../home/domain/entities/doctor_entity.dart';
import '../../../data/repos/doctors_view_repo_impl.dart';

part 'doctors_view_cubit.freezed.dart';
part 'doctors_view_state.dart';

class DoctorsViewCubit extends Cubit<DoctorsViewState> {
  DoctorsViewCubit() : super(const DoctorsViewState.initial());

  Timer? _debounce;

  Future<void> getDoctors() async {
    emit(const DoctorsViewState.getDoctorsLoading());
    final response = await getIt<DoctorsViewRepoImpl>().getDoctors();
    response.fold(
      (l) => emit(DoctorsViewState.getDoctorsFailure(errorMessage: l.message)),
      (r) => emit(DoctorsViewState.getDoctorsSuccess(doctors: r)),
    );
  }

  void searchDoctors({required String query}) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.isEmpty) {
      getDoctors();
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(const DoctorsViewState.searchDoctorsLoading());
      final response = await getIt<DoctorsViewRepoImpl>().searchDoctors(
        query: query,
      );
      response.fold(
        (l) => emit(
          DoctorsViewState.searchDoctorsFailure(errorMessage: l.message),
        ),
        (r) => emit(DoctorsViewState.searchDoctorsSuccess(doctors: r)),
      );
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
