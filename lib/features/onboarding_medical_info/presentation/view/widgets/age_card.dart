import 'package:easy_localization/easy_localization.dart';
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
    final isDark = theme.brightness == Brightness.dark;

    final cardBg =
        isDark
            ? const Color(0xff1F2937).withValues(alpha: 0.4)
            : const Color(0xffF8FAFC);
    final borderColor =
        isDark ? const Color(0xff30363D) : const Color(0xffE2E8F0);
    final infoColor = const Color(0xff06B6D4);

    return BlocBuilder<PatientInfoUiCubit, PatientInfoUiState>(
      builder: (context, state) {
        final childState = context.read<ChildrenInfoUiCubit>().state;

        final currentAge = isChild ? childState.age : state.age;
        final hasBirthDate =
            isChild
                ? context.read<ChildrenInfoUiCubit>().state.birthDate != null
                : state.birthDate != null;

        final String ageDisplay =
            hasBirthDate
                ? "${'years_old'.tr(namedArgs: {'age': currentAge.toString()})}"
                : 'calculated_automatically'.tr();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Text(
                'age_label'.tr(),
                style: TextStyles.H2.copyWith(
                  color: theme.canvasColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color:
                      hasBirthDate
                          ? infoColor.withValues(alpha: 0.4)
                          : borderColor,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    color:
                        hasBirthDate
                            ? infoColor
                            : Colors.grey.withValues(alpha: 0.7),
                    size: 22,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      ageDisplay,
                      style: TextStyles.public.copyWith(
                        color:
                            hasBirthDate
                                ? theme.canvasColor
                                : Colors.grey.withValues(alpha: 0.8),
                        fontWeight:
                            hasBirthDate ? FontWeight.bold : FontWeight.normal,
                        fontStyle:
                            hasBirthDate ? FontStyle.normal : FontStyle.italic,
                      ),
                    ),
                  ),
                  if (hasBirthDate)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: infoColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'auto_calculated'.tr(),
                        style: TextStyle(
                          color: infoColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
