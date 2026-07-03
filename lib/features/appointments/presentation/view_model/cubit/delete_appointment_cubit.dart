import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/helper_function/get_it_service.dart';
import '../../../data/repo/appointments_repo_impl.dart';

part 'delete_appointment_cubit.freezed.dart';
part 'delete_appointment_state.dart';

class DeleteAppointmentCubit extends Cubit<DeleteAppointmentState> {
  DeleteAppointmentCubit() : super(const DeleteAppointmentState.initial());

  Future<void> deleteAppointment({required int appointmentId}) async {
    emit(DeleteAppointmentState.loading(appointmentId: appointmentId));
    final result = await getIt<AppointmentsRepoImpl>().deleteAppointment(
      appointmentId: appointmentId,
    );
    result.fold(
      (failure) => emit(DeleteAppointmentState.error(failure.message)),
      (data) => emit(DeleteAppointmentState.success(message: data)),
    );
  }
}
