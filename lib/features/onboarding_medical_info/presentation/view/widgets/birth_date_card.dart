import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_ui_cubit/children_info_ui_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/patient_info_ui_cubit/patient_info_ui_cubit.dart';
import 'package:provider/provider.dart';

class BirthDateCard extends StatelessWidget {
  const BirthDateCard({super.key, required this.isChild});

  final bool isChild;

  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;

    return Card(
      color: theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Pick your birth date :',
                  style: TextStyles.H2.copyWith(color: theme.canvasColor),
                ),
                const SizedBox(height: 10),
                BlocBuilder<PatientInfoUiCubit, PatientInfoUiState>(
                  builder: (context, state) {
                    final childCubit = context.read<ChildrenInfoUiCubit>();
                    final childState = childCubit.state;
                    final cubit = context.read<PatientInfoUiCubit>();

                    final birthDate =
                        isChild ? childState.birthDate : state.birthDate;

                    Color backgroundColor =
                        birthDate == null
                            ? theme.cardColor
                            : theme.splashColor.withAlpha((0.7 * 255).round());

                    return TextButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        elevation: WidgetStateProperty.all(3),
                        backgroundColor: WidgetStateProperty.all(
                          backgroundColor,
                        ),
                      ),
                      onPressed: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime(1900, 1, 1),
                          maxTime: DateTime.now(),
                          onConfirm: (date) {
                            if (isChild) {
                              childCubit.updateBirthDate(date);
                            } else {
                              cubit.updateBirthDate(date);
                            }
                          },
                          currentTime: birthDate ?? DateTime(2000, 1, 1),
                          locale:
                              context.locale.languageCode == "ar"
                                  ? LocaleType.ar
                                  : LocaleType.en,
                        );
                      },
                      child: Text(
                        birthDate == null
                            ? '+ pick'
                            : DateFormat('yyyy-MM-dd').format(birthDate),
                        style: TextStyles.public.copyWith(
                          color: birthDate == null ? Colors.grey : Colors.white,
                          shadows: [
                            Shadow(
                              color: theme.shadowColor,
                              offset: const Offset(1.0, 0),
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
