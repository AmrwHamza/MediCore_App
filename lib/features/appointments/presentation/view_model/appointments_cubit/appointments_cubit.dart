import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/features/appointments/data/repo/appointments_repo_impl.dart';
import 'package:medicore_app/features/appointments/domain/entities/patient_appointment_entity.dart';

import '../../../../../core/helper_function/get_it_service.dart';

part 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  AppointmentsCubit() : super(AppointmentsInitial());

  Future<void> getAppointments() async {
    if (isClosed) return;
    emit(AppointmentsLoading());
    final response = await getIt<AppointmentsRepoImpl>().getAppointments();
    if (isClosed) return;

    return response.fold(
      (failure) {
        if (isClosed) return;
        if (failure.statusCode == 400) {
          emit(
            const AppointmentsSuccess(
              acceptedPatient: [],
              waitingPatient: [],
              acceptedSon: [],
              waitingSon: [],
            ),
          );
        } else {
          emit(AppointmentsFailure(error: failure.message));
        }
      },
      (appointments) {
        if (isClosed) return;
        final acceptedPatient = appointments.data.acceptedPatient;
        final waitingPatient = appointments.data.waitingPatient;
        final acceptedSon = appointments.data.acceptedSons;
        final waitingSon = appointments.data.waitingSons;
        emit(
          AppointmentsSuccess(
            acceptedPatient: acceptedPatient,
            waitingPatient: waitingPatient,
            acceptedSon: acceptedSon,
            waitingSon: waitingSon,
          ),
        );
      },
    );
  }
}
