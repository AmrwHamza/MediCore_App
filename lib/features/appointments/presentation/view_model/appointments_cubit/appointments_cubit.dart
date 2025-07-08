import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/features/appointments/data/repo/appointments_repo_impl.dart';
import 'package:medicore_app/features/appointments/domain/entities/patient_appointment_entity.dart';

part 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  AppointmentsCubit() : super(AppointmentsInitial());

  Future<void> getAppointments() async {
    emit(AppointmentsLoading());
    final response = await AppointmentsRepoImpl().getAppointments();
    return response.fold(
      (failure) => emit(AppointmentsFailure(error: failure.message)),
      (appointments) {
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
