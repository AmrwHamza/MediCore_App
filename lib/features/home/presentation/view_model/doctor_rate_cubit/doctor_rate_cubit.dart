import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/appointments/data/repo/appointments_repo_impl.dart';
import 'package:medicore_app/features/home/data/repos/doctor_rate_repo_impl.dart';
import 'package:medicore_app/features/home/data/repos/home_repo_impl.dart';
import 'package:medicore_app/features/home/presentation/view_model/doctor_rate_cubit/doctor_rate_state.dart';

class DoctorRateCubit extends Cubit<DoctorRateState> {
  DoctorRateCubit() : super(const DoctorRateInitial());

  Future<void> load({
    required int doctorId,
    bool canRateOverride = false,
  }) async {
    emit(const DoctorRateLoading());

    final averageRate = await _fetchAverageRate(doctorId);
    final canRate = canRateOverride || await _canRateDoctor(doctorId);

    if (isClosed) return;

    if (!canRate) {
      emit(
        DoctorRateLoaded(
          hasRated: false,
          averageRate: averageRate,
          canRate: false,
        ),
      );
      return;
    }

    final userRateResponse =
        await getIt<DoctorRateRepoImpl>().getUserRate(doctorId);

    if (isClosed) return;

    userRateResponse.fold(
      (failure) => emit(
        DoctorRateLoaded(
          hasRated: false,
          averageRate: averageRate,
          canRate: canRate,
        ),
      ),
      (userRate) => emit(
        DoctorRateLoaded(
          userRate: userRate,
          hasRated: userRate != null && userRate > 0,
          averageRate: averageRate,
          canRate: canRate,
        ),
      ),
    );
  }

  Future<void> rate({required int doctorId, required int stars}) async {
    final current = state;
    if (current is! DoctorRateLoaded || current.isSubmitting) return;

    emit(current.copyWith(isSubmitting: true, error: null));
    final response = current.hasRated
        ? await getIt<DoctorRateRepoImpl>().updateRate(doctorId, stars)
        : await getIt<DoctorRateRepoImpl>().addRate(doctorId, stars);

    if (isClosed) return;

    response.fold(
      (failure) => emit(
        current.copyWith(isSubmitting: false, error: failure.message),
      ),
      (message) => emit(
        DoctorRateLoaded(
          userRate: stars.toDouble(),
          hasRated: true,
          averageRate: current.averageRate,
          canRate: current.canRate,
          successMessage: message,
        ),
      ),
    );
  }

  void clearFeedback() {
    final current = state;
    if (current is! DoctorRateLoaded) return;
    emit(current.copyWith(successMessage: null, error: null));
  }

  Future<void> deleteRate({required int doctorId}) async {
    final current = state;
    if (current is! DoctorRateLoaded || current.isSubmitting) return;

    emit(current.copyWith(isSubmitting: true, error: null));
    final response = await getIt<DoctorRateRepoImpl>().deleteRate(doctorId);

    if (isClosed) return;

    response.fold(
      (failure) => emit(
        current.copyWith(isSubmitting: false, error: failure.message),
      ),
      (message) => emit(
        DoctorRateLoaded(
          userRate: null,
          hasRated: false,
          averageRate: current.averageRate,
          canRate: current.canRate,
          successMessage: message,
        ),
      ),
    );
  }

  Future<double?> _fetchAverageRate(int doctorId) async {
    final response = await getIt<HomeRepoImpl>().getDoctorInfo(doctorId);
    return response.fold(
      (failure) => null,
      (info) => info.rate?.toDouble(),
    );
  }

  Future<bool> _canRateDoctor(int doctorId) async {
    final response = await getIt<AppointmentsRepoImpl>().getPrivews();
    return response.fold(
      (failure) => false,
      (previews) {
        final all = [
          ...previews.completePreviews,
          ...previews.partlyPreviews,
          ...previews.completeSons,
          ...previews.partlyPreviewsSons,
        ];
        return all.any(
          (p) => p.doctorId == doctorId && p.diagnoseisType == 1,
        );
      },
    );
  }
}
