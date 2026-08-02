import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_ui_cubit/children_info_ui_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/patient_info_ui_cubit/patient_info_ui_cubit.dart';

class BirthDateCard extends StatelessWidget {
  const BirthDateCard({super.key, required this.isChild});

  final bool isChild;

  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age < 0 ? 0 : age;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    final primaryColor = isDark ? KPrimaryColor : KPrimaryDark;
    final cardBg = isDark ? const Color(0xff161B22) : Colors.white;
    final borderColor =
        isDark ? const Color(0xff30363D) : const Color(0xffE2E8F0);

    return BlocBuilder<PatientInfoUiCubit, PatientInfoUiState>(
      builder: (context, state) {
        final childCubit = context.read<ChildrenInfoUiCubit>();
        final patientCubit = context.read<PatientInfoUiCubit>();

        final birthDate =
            isChild ? childCubit.state.birthDate : state.birthDate;
        final hasDate = birthDate != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Text(
                'birth_date_label'.tr(),
                style: TextStyles.H2.copyWith(
                  color: theme.canvasColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime(1900, 1, 1),
                  maxTime: DateTime.now(),
                  onConfirm: (date) {
                    if (isChild) {
                      childCubit.updateBirthDate(date);
                    } else {
                      patientCubit.updateBirthDate(date);
                    }
                    final calculatedAge = _calculateAge(date);
                    if (isChild) {
                      childCubit.updateAge(calculatedAge);
                    } else {
                      patientCubit.updateAge(calculatedAge);
                    }
                  },
                  currentTime: birthDate ?? DateTime(2000, 1, 1),
                  locale:
                      context.locale.languageCode == "ar"
                          ? LocaleType.ar
                          : LocaleType.en,
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: hasDate ? primaryColor : borderColor,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDark ? 0.2 : 0.03,
                      ),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: hasDate ? primaryColor : Colors.grey,
                      size: 20,
                    ),
                    const SizedBox(width: 14),
                    Text(
                      hasDate
                          ? DateFormat('yyyy-MM-dd').format(birthDate)
                          : 'select_birth_date'.tr(),
                      style: TextStyles.public.copyWith(
                        color: hasDate ? theme.canvasColor : Colors.grey,
                        fontWeight:
                            hasDate ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color:
                          hasDate
                              ? primaryColor
                              : Colors.grey.withValues(alpha: 0.7),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
