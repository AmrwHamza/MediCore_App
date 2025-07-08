import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/core/widget/custom_scroll_widget.dart';
import 'package:medicore_app/features/appointments/domain/entities/patient_appointment_entity.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_card.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/loading_shimer_list.dart';
import 'package:medicore_app/features/appointments/presentation/view_model/appointments_cubit/appointments_cubit.dart';

class AcceptedPage extends StatelessWidget {
  const AcceptedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return CustomScrollWidget(
      onRefresh: () {
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
              ...state.acceptedPatient.map(
                (e) => {'data': e, 'isChild': false},
              ),
              ...state.acceptedSon.expand(
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
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: combinedList.length,
              itemBuilder: (context, index) {
                final item = combinedList[index];
                final appointment = item['data'] as PatientAppointmentEntity;
                final isChild = item['isChild'] as bool;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 4,
                  ),
                  child: AppointmentCard(
                    isDone: isChild,
                    isChild: isChild,
                    imagePath: Assets.imagesMe,
                    patientName: appointment.appointmentInfo.patientImage ?? '',
                    status: appointment.status,
                    date: appointment.appointmentDate,
                    doctorName: appointment.appointmentInfo.doctorName,
                    isMale:
                        appointment.appointmentInfo.gender == "male"
                            ? true
                            : false,
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
