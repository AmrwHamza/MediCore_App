import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_scroll_widget.dart';
import 'package:medicore_app/features/appointments/domain/entities/patient_appointment_entity.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_card.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/loading_shimer_list.dart';
import 'package:medicore_app/features/appointments/presentation/view_model/appointments_cubit/appointments_cubit.dart';

class IncompletePage extends StatelessWidget {
  const IncompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollWidget(
      onRefresh: () async {
        context.read<AppointmentsCubit>().getAppointments();
        return Future.delayed(const Duration(seconds: 1));
      },
      child: BlocBuilder<AppointmentsCubit, AppointmentsState>(
        builder: (context, state) {
          if (state is AppointmentsLoading) {
            return const LoadingShimerList();
          } else if (state is AppointmentsFailure) {
            return Center(child: Text(state.error, style: TextStyles.notes));
          } else if (state is AppointmentsSuccess) {
            final allAppointments = [
              ...state.acceptedPatient.map(
                (e) => {'data': e, 'isChild': false},
              ),
              ...state.waitingPatient.map((e) => {'data': e, 'isChild': false}),
              ...state.acceptedSon.expand(
                (list) => list.map((e) => {'data': e, 'isChild': true}),
              ),
              ...state.waitingSon.expand(
                (list) => list.map((e) => {'data': e, 'isChild': true}),
              ),
            ];

            final incompleteList =
                allAppointments.where((item) {
                  final appointment = item['data'] as PatientAppointmentEntity;
                  return appointment.status == 'Done' ||
                      appointment.status == 'Incomplete';
                }).toList();

            if (incompleteList.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text('no_appointments'.tr(), style: TextStyles.notes),
                ),
              );
            }

            incompleteList.sort((a, b) {
              final aDate =
                  (a['data'] as PatientAppointmentEntity).appointmentDate;
              final bDate =
                  (b['data'] as PatientAppointmentEntity).appointmentDate;
              return bDate.compareTo(aDate);
            });

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: incompleteList.length,
              itemBuilder: (context, index) {
                final item = incompleteList[index];
                final appointment = item['data'] as PatientAppointmentEntity;
                final isChild = item['isChild'] as bool;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 6,
                  ),
                  child: AppointmentCard(
                    isDone: true,
                    isChild: isChild,
                    imagePath: appointment.appointmentInfo.patientImage ?? '',
                    patientName: appointment.appointmentInfo.patientName,
                    status: appointment.status,
                    date: appointment.appointmentDate,
                    doctorName: appointment.appointmentInfo.doctorName,
                    isMale: appointment.appointmentInfo.gender == "male",
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
