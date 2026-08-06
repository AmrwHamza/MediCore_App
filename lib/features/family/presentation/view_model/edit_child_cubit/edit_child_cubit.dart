import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/helper_function/get_it_service.dart';
import '../../../../onboarding_medical_info/domain/entities/get_child_entity.dart';
import '../../../data/repo/family_repo.dart';

part 'edit_child_cubit.freezed.dart';
part 'edit_child_state.dart';

class EditChildCubit extends Cubit<EditChildState> {
  EditChildCubit() : super(const EditChildState.initial());

  Future<void> updateChild({
    required int childId,
    required String firstName,
    required String lastName,
    required String birthDate,
    required String gender,
    required int age,
    required String bloodType,
  }) async {
    emit(const EditChildState.loading());
    final result = await getIt<FamilyRepo>().updateChild(
      childId: childId,
      firstName: firstName,
      lastName: lastName,
      birthDate: birthDate,
      gender: gender,
      age: age,
      bloodType: bloodType,
    );
    result.fold(
      (failure) => emit(EditChildState.failure(failure.message)),
      (child) => emit(EditChildState.success(child)),
    );
  }
}