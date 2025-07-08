import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_scroll_widget.dart';
import 'package:medicore_app/features/appointments/domain/entities/patient_appointment_entity.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_card.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/loading_shimer_list.dart';
import 'package:medicore_app/features/appointments/presentation/view_model/appointments_cubit/appointments_cubit.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

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
            final combinedList = [
              ...state.waitingPatient.map((e) => {'data': e, 'isChild': false}),
              ...state.waitingSon.expand(
                (innerList) =>
                    innerList.map((e) => {'data': e, 'isChild': true}),
              ),
            ];

            combinedList.sort((a, b) {
              final aDate =
                  (a['data'] as PatientAppointmentEntity).appointmentDate;
              final bDate =
                  (b['data'] as PatientAppointmentEntity).appointmentDate;
              return bDate.compareTo(aDate);
            });

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: combinedList.length,
              itemBuilder: (context, index) {
                final item = combinedList[index];
                final appointment = item['data'] as PatientAppointmentEntity;
                final isChild = item['isChild'] as bool;
                final slideDirection = index.isEven ? 0.3 : -0.3;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 4,
                  ),
                  child: AppointmentCard(
                        isDone: false,
                        isChild: isChild,
                        imagePath:
                            appointment.appointmentInfo.patientImage ?? '',
                        patientName: appointment.appointmentInfo.patientName,
                        status: appointment.status,
                        date: appointment.appointmentDate,
                        doctorName: appointment.appointmentInfo.doctorName,
                        isMale: appointment.appointmentInfo.gender == "male",
                      )
                      .animate()
                      .fade(
                        duration: 400.ms,
                        delay: Duration(milliseconds: 100 * index),
                      )
                      .slideX(
                        begin: slideDirection,
                        duration: 500.ms,
                        curve: Curves.easeOutBack,
                      ),
                );
              },
            );
          } else {
            return Center(child: Text('get_appointments_failure'.tr()));
          }
        },
      ),
    );
  }
}
