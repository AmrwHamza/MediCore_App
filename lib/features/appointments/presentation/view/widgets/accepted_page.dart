import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/features/appointments/domain/entities/patient_appointment_entity.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/loading_shimer_list.dart';
import 'package:medicore_app/features/appointments/presentation/view_model/appointments_cubit/appointments_cubit.dart';

import '../../../../../constants.dart';
import '../../../../../core/theme/theme_provider.dart';
import '../../../data/mapper/appointment_mapper.dart';
import '../../view_model/priviews_cubit/priviews_cubit.dart';
import '../appointment_details_view.dart';
import 'empty_appointment_state.dart';
import 'privew_card.dart';

class AcceptedPage extends StatelessWidget {
  const AcceptedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return RefreshIndicator.adaptive(
      backgroundColor: theme.cardColor,
      color: KPrimaryColor,
      onRefresh: () async {
        await context.read<AppointmentsCubit>().getAppointments();
        await context.read<PriviewsCubit>().getPriviews();
      },
      notificationPredicate: (notification) => notification.depth == 0,
      child: BlocBuilder<AppointmentsCubit, AppointmentsState>(
        builder: (context, appointmentsState) {
          return BlocBuilder<PriviewsCubit, PriviewsState>(
            builder: (context, previewsState) {
              if (appointmentsState is AppointmentsLoading ||
                  previewsState is PriviewsLoading) {
                return const LoadingShimerList();
              }
              if (appointmentsState is AppointmentsFailure) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Text(
                      appointmentsState.error,
                      style: TextStyles.notes,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              if (appointmentsState is AppointmentsSuccess) {
                final Set<int> previewAppointmentIds = {};
                if (previewsState is PriviewsSuccess) {
                  for (var preview in previewsState.completePreviews) {
                    previewAppointmentIds.add(preview.appointmentId);
                  }
                  for (var preview in previewsState.completeSons) {
                    previewAppointmentIds.add(preview.appointmentId);
                  }
                }

                final filteredPatientList = appointmentsState.acceptedPatient
                    .where((e) => !previewAppointmentIds.contains(e.id));
                final filteredSonList = appointmentsState.acceptedSon.map(
                  (list) =>
                      list
                          .where((e) => !previewAppointmentIds.contains(e.id))
                          .toList(),
                );

                final combinedList = [
                  ...filteredPatientList.map(
                    (e) => {'data': e, 'isChild': false},
                  ),
                  ...filteredSonList.expand(
                    (list) => list.map((e) => {'data': e, 'isChild': true}),
                  ),
                ];

                combinedList.sort((a, b) {
                  final aDate =
                      (a['data'] as PatientAppointmentEntity).appointmentDate;
                  final bDate =
                      (b['data'] as PatientAppointmentEntity).appointmentDate;
                  return bDate.compareTo(aDate);
                });

                return RefreshIndicator.adaptive(
                  color: KPrimaryColor,
                  backgroundColor: theme.cardColor,
                  onRefresh: () async {
                    await context.read<AppointmentsCubit>().getAppointments();
                    await context.read<PriviewsCubit>().getPriviews();
                  },
                  child:
                      combinedList.isEmpty
                          ? const EmptyAppointmentState()
                          : ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            itemCount: combinedList.length,
                            itemBuilder: (context, index) {
                              final item = combinedList[index];
                              final appointment =
                                  item['data'] as PatientAppointmentEntity;
                              final isChild = item['isChild'] as bool;
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 6.h,
                                ),
                                child: PreviewCard(
                                  appointmentId: appointment.id,
                                  onTap: () {
                                    context.push(
                                      AppointmentDetailsView.routeName,
                                      extra:
                                          AppointmentMapper.fromPrivewToAppointment(
                                            appointment,
                                          ),
                                    );
                                  },
                                  isChild: isChild,
                                  imagePath:
                                      appointment
                                          .appointmentInfo
                                          .patientImage ??
                                      '',
                                  patientName:
                                      appointment.appointmentInfo.patientName,
                                  status: appointment.status,
                                  date: appointment.appointmentDate,
                                  doctorName:
                                      appointment.appointmentInfo.doctorName,
                                  isMale:
                                      appointment.appointmentInfo.gender ==
                                      'male',
                                ),
                              );
                            },
                          ),
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
