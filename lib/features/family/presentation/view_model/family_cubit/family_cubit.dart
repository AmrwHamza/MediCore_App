import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/features/family/data/repo/family_repo.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/childs_entity.dart';

part 'family_state.dart';

class FamilyCubit extends Cubit<FamilyState> {
  FamilyCubit() : super(FamilyInitial());

  Future<void> getChilds() async {
    emit(GetFamilyLoading());
    final response = await FamilyRepo().getChilds();
    response.fold((failure) => emit(GetFamilyFailure(error: failure.message)), (
      childs,
    ) {
      emit(GetFamilySuccess(children: childs));
    });
  }
}
