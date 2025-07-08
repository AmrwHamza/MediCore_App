import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/book_appointment/data/repo/book_appointment_repo_impl.dart';
import 'package:medicore_app/features/book_appointment/domain/entities/symptom_entity.dart';

part 'symptom_analysis_state.dart';

class SymptomAnalysisCubit extends Cubit<SymptomAnalysisState> {
  SymptomAnalysisCubit() : super(SymptomAnalysisInitial());

  List<SymptomEntity> allSymptoms = [];
  List<String> selectedSymptoms = [];
  String search = '';

  List<SymptomEntity> get filteredSymptoms {
    if (search.isEmpty) return allSymptoms;
    return allSymptoms
        .where(
          (s) => s.symptomName.toLowerCase().contains(search.toLowerCase()),
        )
        .toList();
  }

  Future<void> getSymptoms({required String lang}) async {
    emit(GetSymptomsLoading());
    final response = await getIt<BookAppointmentRepoImpl>().getSymptoms(
      lang: lang,
    );

    response.fold(
      (failure) => emit(GetSymptomsFailure(message: failure.message)),
      (data) {
        allSymptoms = data.data;
        emit(GetSymptomsSuccess(symptoms: filteredSymptoms));
      },
    );
  }

  void searchOfSymptoms(String query) {
    search = query;
    emit(GetSymptomsSuccess(symptoms: filteredSymptoms));
  }

  void selectSymptom(String symptom) {
    if (selectedSymptoms.contains(symptom)) {
      selectedSymptoms.remove(symptom);
    } else {
      selectedSymptoms.add(symptom);
    }
    emit(SymptomSelectionChanged(List.from(selectedSymptoms)));
  }

  Future<void> analyseSymptoms() async {
    if (selectedSymptoms.isEmpty) return;
    emit(SymptomAnalysisLoading());

    final response = await getIt<BookAppointmentRepoImpl>().analyseSymptoms(
      selectedSymptoms,
    );

    response.fold(
      (failure) => emit(SymptomAnalysisFailure(message: failure.message)),
      (data) => emit(
        SymptomAnalysisSuccess(
          departmentId: data.suggestedDepartmentId,
          message: data.message,
        ),
      ),
    );
  }
}
