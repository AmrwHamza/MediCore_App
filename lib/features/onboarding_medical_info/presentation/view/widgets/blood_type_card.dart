import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_ui_cubit/children_info_ui_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/patient_info_ui_cubit/patient_info_ui_cubit.dart';

class BloodTypeCard extends StatelessWidget {
  const BloodTypeCard({super.key, required this.isChild});

  final bool isChild;

  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;

    return Card(
      color: theme.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 12),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: BlocBuilder<PatientInfoUiCubit, PatientInfoUiState>(
          builder: (context, state) {
            final childCubit = context.read<ChildrenInfoUiCubit>();
            final childState = context.read<ChildrenInfoUiCubit>().state;
            final cubit = context.read<PatientInfoUiCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Blood Type",
                  style: TextStyles.H2.copyWith(color: theme.canvasColor),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.center,
                  child: IntrinsicWidth(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: theme.splashColor,
                          width: 1.5,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value:
                              isChild ? childState.bloodType : state.bloodType,
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down_rounded,
                            color: theme.canvasColor,
                          ),
                          dropdownColor: theme.cardColor,
                          style: TextStyles.public.copyWith(
                            color: theme.canvasColor,
                          ),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              isChild
                                  ? childCubit.updateBloodType(newValue)
                                  : cubit.updateBloodType(newValue);
                            }
                          },
                          items:
                              <String>[
                                'A+',
                                'A-',
                                'B+',
                                'B-',
                                'AB+',
                                'AB-',
                                'O+',
                                'O-',
                              ].map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
