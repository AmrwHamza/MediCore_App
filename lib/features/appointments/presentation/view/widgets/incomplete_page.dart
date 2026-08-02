import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/loading_shimer_list.dart';
import 'package:medicore_app/features/appointments/presentation/view_model/appointments_cubit/appointments_cubit.dart';

import '../../../../../constants.dart';
import '../../../../../core/theme/theme_provider.dart';
import '../../../data/models/appointment_types.dart';
import '../../../domain/entities/privew_entity.dart';
import '../../view_model/priviews_cubit/priviews_cubit.dart';
import '../appointment_details_view.dart';
import 'empty_appointment_state.dart';
import 'privew_card.dart';

class IncompletePage extends StatelessWidget {
  const IncompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return RefreshIndicator.adaptive(
      color: KPrimaryColor,
      backgroundColor: theme.cardColor,
      onRefresh: () async {
        await context.read<PriviewsCubit>().getPriviews();
      },
      notificationPredicate: (notification) => notification.depth == 0,
      child: BlocBuilder<PriviewsCubit, PriviewsState>(
        builder: (context, state) {
          if (state is PriviewsLoading) {
            return const LoadingShimerList();
          }

          if (state is PriviewsFailure) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Text(
                  state.error,
                  style: TextStyles.notes,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (state is PriviewsSuccess) {
            final allAppointments = [
          
              ...state.partlyPreviews.map(
                (e) => {
                  'data': e,
                  'isChild': false,
                  'status': AppointmentTypes.incomplete,
                },
              ),
         
              ...state.partlyPreviewsSons.map(
                (e) => {
                  'data': e,
                  'isChild': true,
                  'status': AppointmentTypes.incomplete,
                },
              ),
            ];

            final incompleteList =
                allAppointments.where((item) {
                  final status = item['status'] as AppointmentTypes;
                  return status == AppointmentTypes.incomplete;
                }).toList();

            incompleteList.sort((a, b) {
              final aDate = (a['data'] as PrivewEntity).date;
              final bDate = (b['data'] as PrivewEntity).date;
              return bDate.compareTo(aDate);
            });

            return RefreshIndicator.adaptive(
              color: KPrimaryColor,
              backgroundColor: theme.cardColor,

              onRefresh: () async {
                await context.read<AppointmentsCubit>().getAppointments();
              },
              child:
                  incompleteList.isEmpty
                      ? const EmptyAppointmentState()
                      : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        itemCount: incompleteList.length,
                        itemBuilder: (context, index) {
                          final item = incompleteList[index];
                          final appointment = item['data'] as PrivewEntity;
                          final isChild = item['isChild'] as bool;
                          final status = item['status'] as AppointmentTypes;

                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 8.h,
                            ),
                            child: PreviewCard(
                              canDelete: false,
                              appointmentId: appointment.id,
                              onTap: () {
                                context.push(
                                  AppointmentDetailsView.routeName,
                                  extra: appointment,
                                );
                              },
                              isChild: isChild,
                              imagePath: appointment.imgPath,
                              patientName: appointment.patientName,
                              status: status,
                              date: DateTime.parse(appointment.date),
                              doctorName: appointment.doctorName,
                              isMale: appointment.gender == 'male',
                            ),
                          );
                        },
                      ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
