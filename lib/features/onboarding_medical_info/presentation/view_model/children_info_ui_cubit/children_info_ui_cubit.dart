import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'children_info_ui_state.dart';

class ChildrenInfoUiCubit extends Cubit<ChildrenInfoUiState> {
  final PageController pageController = PageController();
  int currentPageIndex = 0;
  String? gender;
  DateTime? birthDate;

  ChildrenInfoUiCubit() : super(ChildrenInfoUiState()) {}

  void updateHasChildren(bool val) => emit(state.copyWith(hasChildren: val));

  void updateBirthDate(DateTime date) {
    birthDate = date;
    emit(state.copyWith(birthDate: date));
  }

  void updateAge(int age) {
    if (age >= 0) {
      emit(state.copyWith(age: age));
    }
  }

  void updateBloodType(String bloodType) =>
      emit(state.copyWith(bloodType: bloodType));

  void updateGender(String value) {
    gender = value;
    emit(state.copyWith(gender: value));
  }

  void updateDisease(bool val) => emit(state.copyWith(showDiseaseField: val));
  void updateMedication(bool val) =>
      emit(state.copyWith(showMedicationField: val));
  void updateAllergy(bool val) => emit(state.copyWith(showAllergyField: val));
  void updateSurgery(bool val) => emit(state.copyWith(showSurgeryField: val));
  void updatePreviousIllnesses(bool val) =>
      emit(state.copyWith(showPreviousIllnesses: val));

  @override
  Future<void> close() {
    state.disposeControllers();
    pageController.dispose();
    return super.close();
  }
}
