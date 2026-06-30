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
import 'package:medicore_app/features/book_appointment/presentation/view_model/symptom_analysis_cubit/symptom_analysis_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/widgets/symptoms_bottom_sheet.dart';

class SelectSymptomsSection extends StatelessWidget {
  const SelectSymptomsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<SymptomAnalysisCubit, SymptomAnalysisState>(
      builder: (context, state) {
        final cubit = context.read<SymptomAnalysisCubit>();
        final selectedSymptoms = cubit.selectedSymptoms;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selectedSymptoms.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'selected_symptoms_title'.tr(),
                    style: TextStyle(
                      color: theme.disabledColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => openBottomSheet(context),
                    icon: const Icon(
                      Icons.edit_rounded,
                      color: KPrimaryColor,
                      size: 16,
                    ),
                    label: Text(
                      'edit_symptoms'.tr(),
                      style: TextStyles.notes.copyWith(
                        color: KPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color:
                        isDark
                            ? Colors.white12
                            : theme.shadowColor.withAlpha(15),
                  ),
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      selectedSymptoms.map((symptom) {
                        return Chip(
                          label: Text(
                            symptom,
                            style: TextStyles.notes.copyWith(
                              color: isDark ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: KPrimaryColor.withAlpha(50),
                            ),
                          ),
                          deleteIconColor: Colors.redAccent,
                          backgroundColor: KPrimaryColor.withAlpha(20),
                          deleteIcon: const Icon(Icons.close_rounded, size: 14),
                          onDeleted: () => cubit.selectSymptom(symptom),
                        );
                      }).toList(),
                ),
              ),
              const SizedBox(height: 16),
            ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => openBottomSheet(context),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: KPrimaryColor.withAlpha(100),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.add_circle_outline_rounded,
                            color: KPrimaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'select_symptoms'.tr(),
                            style: TextStyles.notes.copyWith(
                              color: KPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
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
                  return const Center(
                    child: SpinKitThreeInOut(color: KPrimaryColor, size: 30),
                  );
                }
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
                          const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 14,
                          ),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
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
                          fontWeight: FontWeight.bold,
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
      backgroundColor: Colors.transparent,
      builder:
          (_) => BlocProvider.value(
            value: context.read<SymptomAnalysisCubit>(),
            child: const SymptomBottomSheet(),
          ),
    );
  }
}
