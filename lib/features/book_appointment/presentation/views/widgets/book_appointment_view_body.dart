import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/book_cubit/book_appointment_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/widgets/calender_section.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/widgets/department_section.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/widgets/doctor_section.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/widgets/select_symptoms_section.dart';

class BookAppointmentViewBody extends StatelessWidget {
  const BookAppointmentViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'analyze_symptoms'.tr(),
            style: TextStyles.H2.copyWith(color: theme.canvasColor),
          ),
          const SizedBox(height: 6),
          Text('directing_symptoms'.tr(), style: TextStyles.notes),
          const SizedBox(height: 6),
          const SelectSymptomsSection(),
          const SizedBox(height: 20),
          const Divider(),
          Text(
            'select_department'.tr(),
            style: TextStyles.H2.copyWith(color: theme.canvasColor),
          ),
          const SizedBox(height: 6),
          const DepartmentSection(),
          const SizedBox(height: 20),
          const Divider(),
          Text(
            'select_doctor'.tr(),
            style: TextStyles.H2.copyWith(color: theme.canvasColor),
          ),
          const SizedBox(height: 6),
          const DoctorSection(),
          const SizedBox(height: 20),
          const Divider(),

          const CalenderSection(),

          const SizedBox(height: 20),
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
