import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/features/onboarding_medical_info/data/repo/medical_repo.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/child_entity.dart';

part 'children_info_state.dart';

class ChildrenInfoCubit extends Cubit<ChildrenInfoState> {
  ChildrenInfoCubit() : super(ChildrenInfoInitial());

  final List<ChildEntity> _children = [];
  List<ChildEntity> get children => List.unmodifiable(_children);

  Future<void> addChild(Map<String, dynamic> data) async {
    emit(AddChildLoading());
    final result = await MedicalRepo().addChild(data);
    result.fold((failure) => emit(ChildFailure(error: failure.message)), (
      childData,
    ) {
      // LoggerHelper.warning(childData.childInfo.gender);

      _children.add(childData);
      emit(AddChildSuccess(child: childData));
    });
  }

  Future<void> deleteChild(ChildEntity child) async {
    emit(AddChildLoading());
    final result = await MedicalRepo().deleteChild(child.id);
    result.fold((failure) => emit(ChildFailure(error: failure.message)), (
      data,
    ) {
      _children.remove(child);
      emit(DeleteChildSuccess(message: data));
    });
  }

  Future<void> deleteChildById(int id) async {
    emit(DeleteChildLoading());
    final result = await MedicalRepo().deleteChild(id);
    result.fold((failure) => emit(ChildFailure(error: failure.message)), (
      data,
    ) {
      emit(DeleteChildSuccess(message: data));
    });
  }
}
