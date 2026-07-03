import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/book_cubit/book_appointment_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/widgets/calender_section.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/widgets/custom_divider.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/widgets/department_section.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/widgets/doctor_section.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/widgets/section_header.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/widgets/select_symptoms_section.dart';

import '../../../../appointments/presentation/view_model/appointments_cubit/appointments_cubit.dart';
import 'child_or_me_selector.dart';
import 'payment_section.dart';

class BookAppointmentViewBody extends StatelessWidget {
  const BookAppointmentViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'select_patient'.tr(),
            subtitle: 'choose_who_is_booking'.tr(),
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 12),
          const ChildOrMeSelector(),

          const CustomDivider(),

          SectionHeader(
            title: 'analyze_symptoms'.tr(),
            subtitle: 'directing_symptoms'.tr(),
            icon: Icons.analytics_outlined,
          ),
          const SizedBox(height: 12),
          const SelectSymptomsSection(),

          const CustomDivider(),

          SectionHeader(
            title: 'select_department'.tr(),
            subtitle: 'choose_specialty_message'.tr(),
            icon: Icons.local_hospital_outlined,
          ),
          const SizedBox(height: 12),
          const DepartmentSection(),

          const CustomDivider(),

          SectionHeader(
            title: 'select_doctor'.tr(),
            subtitle: 'choose_your_doctor_message'.tr(),
            icon: Icons.medication_outlined,
          ),
          const SizedBox(height: 12),
          const DoctorSection(),

          const CustomDivider(),

          SectionHeader(
            title: 'select_date_time'.tr(),
            subtitle: 'choose_best_slot'.tr(),
            icon: Icons.calendar_month_outlined,
          ),
          const SizedBox(height: 12),
          const CalenderSection(),

          const CustomDivider(),
          SectionHeader(
            title: 'select_payment'.tr(),
            subtitle: 'choose_payment'.tr(),
            icon: Icons.attach_money,
          ),
          const SizedBox(height: 12),
          const PaymentSection(),

          const SizedBox(height: 32),
          Center(
            child: BlocConsumer<BookAppointmentCubit, BookAppointmentState>(
              listener: (context, state) {
                if (state is BookAppointmentFailure) {
                  CustomSnackbar.show(
                    context,
                    message: state.error,
                    type: SnackbarType.error,
                  );
                } else if (state is BookAppointmentSuccess) {
                  CustomSnackbar.show(
                    context,
                    message: state.message,
                    type: SnackbarType.success,
                  );

                  context.pop();
                }
              },
              builder: (context, state) {
                final cubit = context.watch<BookAppointmentCubit>();
                final selectedDoctor = cubit.selectedDoctorId;
                if (state is BookAppointmentLoading) {
                  return const SpinKitThreeBounce(color: KPrimaryColor);
                }
                return CustomButton(
                  title: 'book_appointment'.tr(),
                  color: KPrimaryColor,
                  onTap: () {
                    if (selectedDoctor == null) {
                      CustomSnackbar.show(
                        context,
                        message: 'select_doctor_message'.tr(),
                        type: SnackbarType.warning,
                      );
                      return;
                    }
                    cubit.bookAppointment(doctorId: selectedDoctor);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
