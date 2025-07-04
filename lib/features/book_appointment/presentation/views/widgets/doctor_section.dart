import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/book_cubit/book_appointment_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/doctor_cubit/doctor_book_appointment_cubit.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/doctor_card_in_home.dart';

class DoctorSection extends StatelessWidget {
  const DoctorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorBookAppointmentCubit, DoctorBookAppointmentState>(
      listener: (context, state) {
        if (state is GetDoctorsInDepartmentFailure) {
          CustomSnackbar.show(
            context,
            message: state.error,
            type: SnackbarType.error,
          );
        }
      },
      builder: (context, doctorState) {
        if (doctorState is DoctorsLoading) {
          return const Center(child: SpinKitThreeBounce(color: KOrange));
        } else if (doctorState is GetDoctorsInDepartmentSuccess) {
          final selectedDoctorId =
              context.watch<BookAppointmentCubit>().selectedDoctorId;
          final doctors = doctorState.doctors;

          if (doctors.isEmpty) {
            return Center(child: Text('no_doctors_available'.tr()));
          }

          return SizedBox(
            height: MediaQuery.of(context).size.width / 2.1,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: doctors.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final doctor = doctors[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DoctorCardInHome(
                    isSelected: selectedDoctorId == doctor.doctorId,
                    name: 'dr'.tr() + ' ${doctor.user.firstName}',
                    department: doctor.department?.name ?? '',
                    rating: doctor.rate ?? 0.0,
                    imageUrl: doctor.user.imagePath,
                    onTap: () {
                      context.read<BookAppointmentCubit>().setSelectedDoctorId(
                        doctor.doctorId,
                      );
                    },
                  ),
                );
              },
            ),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(KOrange),
                  elevation: WidgetStateProperty.all(2),
                ),
                onPressed: () {
                  context.read<DoctorBookAppointmentCubit>().getAllDoctors();
                },
                child: Text(
                  'pick_doctor'.tr(),
                  style: TextStyles.button.copyWith(color: Colors.white),
                ),
              ),
            ],
          );
          // Center(
          //   child: SizedBox(
          //     height: MediaQuery.of(context).size.width / 10,
          //     width: MediaQuery.of(context).size.width / 3,
          //     child: CustomButton(
          //       title: 'pick_doctor'.tr(),
          //       color: KPrimaryColor,
          //       onTap: () {
          //         context.read<DoctorBookAppointmentCubit>().getAllDoctors();
          //       },
          //     ),
          //   ),
          // );
        }
      },
    );
  }
}
