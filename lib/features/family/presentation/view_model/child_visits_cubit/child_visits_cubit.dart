import 'package:bloc/bloc.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/family/data/repo/family_repo.dart';
import 'package:medicore_app/features/family/presentation/view_model/child_visits_cubit/child_visits_state.dart';

class ChildVisitsCubit extends Cubit<ChildVisitsState> {
  ChildVisitsCubit() : super(ChildVisitsInitial());

  Future<void> getChildVisits({required num patientId}) async {
    if (state is! ChildVisitsSuccess) {
      emit(ChildVisitsLoading());
    }
    final response = await getIt<FamilyRepo>().getChildPreviews(
      patientId: patientId,
    );
    response.fold(
      (failure) => emit(ChildVisitsFailure(error: failure.message)),
      (previews) => emit(ChildVisitsSuccess(previews: previews)),
    );
  }
}
