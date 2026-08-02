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
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 16,
                        decoration: BoxDecoration(
                          color: KPrimaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'selected_symptoms_title'.tr(),
                        style: TextStyle(
                          color: isDark ? Colors.white70 : theme.disabledColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () => openBottomSheet(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      backgroundColor: KPrimaryColor.withValues(alpha: 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(
                      Icons.edit_note_rounded,
                      color: KPrimaryColor,
                      size: 18,
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
              const SizedBox(height: 12),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDark ? 0.2 : 0.03,
                      ),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(
                    color:
                        isDark
                            ? Colors.white10
                            : KPrimaryColor.withValues(alpha: 0.08),
                  ),
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children:
                      selectedSymptoms.map((symptom) {
                        return InputChip(
                          label: Text(symptom),
                          labelStyle: TextStyles.notes.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(
                            color: KPrimaryColor.withValues(alpha: 0.15),
                          ),
                          elevation: 0,
                          pressElevation: 2,
                          deleteIconColor: Colors.redAccent.withValues(
                            alpha: 0.8,
                          ),
                          backgroundColor: Colors.grey,
                          deleteIcon: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red.withValues(alpha: 0.15),
                            ),
                            child: const Center(
                              child: Icon(Icons.delete, size: 16),
                            ),
                          ),
                          onDeleted: () => cubit.selectSymptom(symptom),
                        );
                      }).toList(),
                ),
              ),
              const SizedBox(height: 20),
            ] else ...[
              InkWell(
                onTap: () => openBottomSheet(context),
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 28,
                  ),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: KPrimaryColor.withValues(alpha: 0.25),
                      width: 1.5,
                      style: BorderStyle.solid,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: KPrimaryColor.withValues(
                          alpha: isDark ? 0.05 : 0.02,
                        ),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: KPrimaryColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.medication_liquid_rounded,
                          color: KPrimaryColor,
                          size: 36,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'select_symptoms'.tr(),
                        style: const TextStyle(
                          color: KPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'select_symptoms_message'.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: theme.disabledColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: SpinKitThreeInOut(color: KPrimaryColor, size: 32),
                    ),
                  );
                }
                return Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: KPrimaryColor.withValues(alpha: 0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KPrimaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
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
                        context.read<SymptomAnalysisCubit>().analyseSymptoms();
                      }
                    },
                    child: Text(
                      'analyze'.tr(),
                      style: TextStyles.button.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
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
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder:
          (_) => BlocProvider.value(
            value: context.read<SymptomAnalysisCubit>(),
            child: const SymptomBottomSheet(),
          ),
    );
  }
}
