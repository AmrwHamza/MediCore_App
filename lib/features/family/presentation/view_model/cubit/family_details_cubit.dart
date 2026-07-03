import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/helper_function/get_it_service.dart';
import '../../../../appointments/domain/entities/privew_entity.dart';
import '../../../data/repo/family_repo.dart';

part 'family_details_cubit.freezed.dart';
part 'family_details_state.dart';

class FamilyDetailsCubit extends Cubit<FamilyDetailsState> {
  FamilyDetailsCubit() : super(const FamilyDetailsState.initial());

  Future<void> getChildAppointment({required int patientId}) async {
    emit(const FamilyDetailsState.loading());
    final response = await getIt<FamilyRepo>().getChildAppointment(
      patientId: patientId,
    );
    response.fold(
      (failure) => emit(FamilyDetailsState.failure(failure.message)),
      (privew) => emit(FamilyDetailsState.success(privew)),
    );
  }
}
