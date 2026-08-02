import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/book_cubit/book_appointment_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/doctor_cubit/doctor_book_appointment_cubit.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/doctor_card_in_home.dart';

class DoctorSection extends StatefulWidget {
  const DoctorSection({super.key});

  @override
  State<DoctorSection> createState() => _DoctorSectionState();
}

class _DoctorSectionState extends State<DoctorSection> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToSelected(int index, int totalItems) {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final target = (maxScroll / (totalItems - 1)) * index;
    _scrollController.animateTo(
      target.clamp(0.0, maxScroll),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

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
          return const Center(
            child: SpinKitThreeBounce(color: KPrimaryColor, size: 30),
          );
        } else if (doctorState is GetDoctorsInDepartmentSuccess) {
          final selectedDoctorId =
              context.watch<BookAppointmentCubit>().selectedDoctorId;
          final doctors = doctorState.doctors;

          if (doctors.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'no_doctors_in_dept'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.disabledColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }

          return SizedBox(
            height: MediaQuery.of(context).size.width / 1.8,
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              itemCount: doctors.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                final isSelected = selectedDoctorId == doctor.doctorId;

                if (isSelected && _scrollController.hasClients) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToSelected(index, doctors.length);
                  });
                }

                return AnimatedScale(
                  scale: isSelected ? 1.03 : 1.0,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutBack,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow:
                          isSelected
                              ? [
                                BoxShadow(
                                  color: KPrimaryColor.withAlpha(30),
                                  blurRadius: 14,
                                  offset: const Offset(0, 8),
                                ),
                              ]
                              : [],
                    ),
                    child: DoctorCardInHome(
                      index: index,
                      isSelected: isSelected,
                      doctor: doctor,
                      onTap: () {
                        context
                            .read<BookAppointmentCubit>()
                            .setSelectedDoctorId(doctor.doctorId);
                        _scrollToSelected(index, doctors.length);
                      },
                    ),
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
                  backgroundColor: WidgetStateProperty.all(KPrimaryColor),
                  elevation: WidgetStateProperty.all(4),
                  shadowColor: WidgetStateProperty.all(
                    KPrimaryColor.withAlpha(100),
                  ),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                onPressed: () {
                  context.read<DoctorBookAppointmentCubit>().getAllDoctors();
                },
                child: Text(
                  'pick_doctor'.tr(),
                  style: TextStyles.button.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
