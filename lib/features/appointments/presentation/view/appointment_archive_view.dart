import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants.dart';
import '../../../../core/helper/text_styles.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../data/models/appointment_types.dart';
import '../../domain/entities/privew_entity.dart';
import '../view_model/priviews_cubit/priviews_cubit.dart';
import 'appointment_details_view.dart';
import 'widgets/empty_appointment_state.dart';
import 'widgets/loading_shimer_list.dart';
import 'widgets/privew_card.dart';

class AppointmentArchiveView extends StatelessWidget {
  static const String routeName = '/appointment-archive';

  const AppointmentArchiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'appointment_archive'.tr(), isMainBar: false),
      body: BlocProvider(
        create: (context) => PriviewsCubit()..getPriviews(),
        child: const AppointmentArchiveViewBody(),
      ),
    );
  }
}

class AppointmentArchiveViewBody extends StatelessWidget {
  const AppointmentArchiveViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      color: KPrimaryColor,
      onRefresh: () async {
        await context.read<PriviewsCubit>().getPriviews();
      },
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
              ...state.completePreviews.map(
                (e) => {
                  'data': e,
                  'isChild': false,
                  'status': AppointmentTypes.complete,
                },
              ),
              ...state.completeSons.map(
                (e) => {
                  'data': e,
                  'isChild': true,
                  'status': AppointmentTypes.complete,
                },
              ),
            ];

            final completeList =
                allAppointments.where((item) {
                  final status = item['status'] as AppointmentTypes;
                  return status == AppointmentTypes.complete;
                }).toList();

            completeList.sort((a, b) {
              final aDate = (a['data'] as PrivewEntity).date;
              final bDate = (b['data'] as PrivewEntity).date;
              return bDate.compareTo(aDate);
            });

            return RefreshIndicator.adaptive(
              onRefresh: () async {
                await context.read<PriviewsCubit>().getPriviews();
              },
              child:
                  completeList.isEmpty
                      ? const EmptyAppointmentState()
                      : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        itemCount: completeList.length,
                        itemBuilder: (context, index) {
                          final item = completeList[index];
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
