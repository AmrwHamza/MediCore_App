import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_ui_cubit/children_info_ui_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/patient_info_ui_cubit/patient_info_ui_cubit.dart';

class AgeCard extends StatelessWidget {
  const AgeCard({super.key, required this.isChild});

  final bool isChild;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return Card(
      color: theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: BlocBuilder<PatientInfoUiCubit, PatientInfoUiState>(
          builder: (context, state) {
            final childCubit = context.read<ChildrenInfoUiCubit>();
            final childState = context.read<ChildrenInfoUiCubit>().state;
            final cubit = context.read<PatientInfoUiCubit>();
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Select your age:',
                      style: TextStyles.H2.copyWith(color: theme.canvasColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isChild
                          ? childState.age.toString()
                          : state.age.toString(),
                      style: TextStyles.H2.copyWith(
                        color: theme.canvasColor,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 45,
                          height: 45,
                          child: FloatingActionButton(
                            heroTag: 'remove',
                            backgroundColor: theme.splashColor,
                            onPressed: () {
                              isChild
                                  ? ((childState.age > 0)
                                      ? childCubit.updateAge(childState.age - 1)
                                      : childCubit.updateAge(0))
                                  : ((state.age > 0)
                                      ? cubit.updateAge(state.age - 1)
                                      : cubit.updateAge(0));
                            },
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 45,
                          height: 45,
                          child: FloatingActionButton(
                            heroTag: 'add',
                            backgroundColor: theme.splashColor,
                            onPressed: () {
                              isChild
                                  ? childCubit.updateAge(childState.age + 1)
                                  : cubit.updateAge(state.age + 1);
                            },
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ],
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
