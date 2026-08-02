import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/helper_function/get_it_service.dart';
import '../../../data/repo/appointments_repo_impl.dart';
import '../../../domain/entities/privew_entity.dart';

part 'priviews_state.dart';

class PriviewsCubit extends Cubit<PriviewsState> {
  PriviewsCubit() : super(PriviewsInitial());

  Future<void> getPriviews() async {
    emit(PriviewsLoading());
    final response = await getIt<AppointmentsRepoImpl>().getPrivews();
    return response.fold(
      (failure) {
        print('💕💕💕💕💕💕💕💕💕💕${failure.statusCode}');
        if (failure.statusCode == 400) {
          emit(
            PriviewsSuccess(
              completePreviews: [],
              partlyPreviews: [],
              completeSons: [],
              partlyPreviewsSons: [],
            ),
          );
        } else {
          emit(PriviewsFailure(error: failure.message));
        }
      },
      (privews) {
        final completePreviews = privews.completePreviews;
        final partlyPreviews = privews.partlyPreviews;
        final completeSons = privews.completeSons;
        final partlyPreviewsSons = privews.partlyPreviewsSons;
        emit(
          PriviewsSuccess(
            completePreviews: completePreviews,
            partlyPreviews: partlyPreviews,
            completeSons: completeSons,
            partlyPreviewsSons: partlyPreviewsSons,
          ),
        );
      },
    );
  }
}
