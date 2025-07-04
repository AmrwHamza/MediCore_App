import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_ui_cubit/children_info_ui_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/patient_info_ui_cubit/patient_info_ui_cubit.dart';

class GenderCard extends StatelessWidget {
  const GenderCard({super.key, required this.isChild});

  final bool isChild;

  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;
    return Card(
      color: theme.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: BlocBuilder<PatientInfoUiCubit, PatientInfoUiState>(
          builder: (context, state) {
            final cubit = context.read<PatientInfoUiCubit>();
            final childCubit = context.read<ChildrenInfoUiCubit>();
            final childState = context.read<ChildrenInfoUiCubit>().state;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Select your gender :',
                  style: TextStyles.H2.copyWith(color: theme.canvasColor),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: 'male',
                      groupValue: isChild ? childState.gender : state.gender,
                      activeColor: KPrimaryColor,
                      onChanged: (value) {
                        if (value != null) {
                          isChild
                              ? childCubit.updateGender(value)
                              : cubit.updateGender(value);
                        }
                      },
                    ),
                    Text(
                      "Male",
                      style: TextStyles.public.copyWith(
                        color: theme.canvasColor,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Radio<String>(
                      value: 'female',
                      groupValue: isChild ? childState.gender : state.gender,
                      activeColor: KPrimaryColor,
                      onChanged: (value) {
                        if (value != null) {
                          isChild
                              ? childCubit.updateGender(value)
                              : cubit.updateGender(value);
                        }
                      },
                    ),
                    Text(
                      "Female",
                      style: TextStyles.public.copyWith(
                        color: theme.canvasColor,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
