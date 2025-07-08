import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/book_cubit/book_appointment_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/doctor_cubit/doctor_book_appointment_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/symptom_analysis_cubit/symptom_analysis_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/widgets/symptoms_bottom_sheet.dart';

class SelectSymptomsSection extends StatelessWidget {
  const SelectSymptomsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SymptomAnalysisCubit, SymptomAnalysisState>(
      builder: (context, state) {
        final cubit = context.read<SymptomAnalysisCubit>();
        final selectedSymptoms = cubit.selectedSymptoms;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            if (selectedSymptoms.isNotEmpty)
              TextButton.icon(
                onPressed: () => openBottomSheet(context),
                icon: const Icon(Icons.edit, color: KPrimaryColor),
                label: Text(
                  'edit_symptoms'.tr(),
                  style: TextStyles.notes.copyWith(
                    color: KPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children:
                      selectedSymptoms.map((symptom) {
                        return Chip(
                          label: Text(
                            symptom,
                            style: TextStyles.notes.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 0.5,
                            ),
                          ),
                          deleteIconColor: Colors.red,
                          backgroundColor: Colors.blueGrey,
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () => cubit.selectSymptom(symptom),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 16),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(Colors.white),
                    elevation: WidgetStateProperty.all(100),
                  ),
                  onPressed: () => openBottomSheet(context),
                  child: Text(
                    'select_symptoms'.tr(),
                    style: TextStyles.notes.copyWith(
                      color: KOrange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            BlocConsumer<SymptomAnalysisCubit, SymptomAnalysisState>(
              listener: (context, state) {
                if (state is SymptomAnalysisFailure) {
                  CustomSnackbar.show(
                    context,
                    message: state.message,
                    type: SnackbarType.error,
                  );
                }
                if (state is SymptomAnalysisSuccess) {
                  final bookCubit = context.read<BookAppointmentCubit>();
                  bookCubit.setSelectedDepartmentId(state.departmentId);
                  context
                      .read<DoctorBookAppointmentCubit>()
                      .getDoctorsInDepartment(state.departmentId);

                  CustomSnackbar.show(
                    context,
                    message: state.message,
                    type: SnackbarType.success,
                  );
                }
              },
              builder: (context, state) {
                if (state is SymptomAnalysisLoading) {
                  return const SpinKitThreeInOut(color: KOrange);
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(KOrange),
                        elevation: WidgetStateProperty.all(2),
                      ),
                      onPressed: () {
                        if (selectedSymptoms.isEmpty) {
                          CustomSnackbar.show(
                            context,
                            message: 'select_symptoms_message'.tr(),
                            type: SnackbarType.warning,
                          );
                        } else {
                          context
                              .read<SymptomAnalysisCubit>()
                              .analyseSymptoms();
                        }
                      },
                      child: Text(
                        'analyze'.tr(),
                        style: TextStyles.button.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (_) => BlocProvider.value(
            value: context.read<SymptomAnalysisCubit>(),
            child: const SymptomBottomSheet(),
          ),
    );
  }
}
