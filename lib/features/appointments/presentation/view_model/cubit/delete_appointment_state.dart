part of 'delete_appointment_cubit.dart';

@freezed
class DeleteAppointmentState with _$DeleteAppointmentState {
  const factory DeleteAppointmentState.initial() = _Initial;
  const factory DeleteAppointmentState.loading({required int appointmentId}) = _Loading;
  const factory DeleteAppointmentState.success({required String message}) = _Success;
  const factory DeleteAppointmentState.error(String message) = _Error;
}
