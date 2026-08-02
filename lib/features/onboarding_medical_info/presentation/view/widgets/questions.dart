import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/age_card.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/birth_date_card.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/blood_type_card.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/gender_card.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/yes_no_question.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/Handler%20Questions/info_ui_handler.dart';

class Questions extends StatelessWidget {
  final bool isChild;
  final InfoUiHandler uiHandler;

  const Questions({super.key, required this.isChild, required this.uiHandler});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final containerColor = isDark ? const Color(0xff161B22) : Colors.white;
    final borderColor =
        isDark ? const Color(0xff30363D) : const Color(0xffE2E8F0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: isDark ? KPrimaryDark : KPrimaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "medical_profile_section".tr(),
                style: TextStyle(
                  color:
                      isDark
                          ? const Color(0xffF9FAFB)
                          : const Color(0xff111827),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BirthDateCard(isChild: isChild),
          const SizedBox(height: 16),
          AgeCard(isChild: isChild),
          const SizedBox(height: 16),
          BloodTypeCard(isChild: isChild),
          const SizedBox(height: 16),
          GenderCard(isChild: isChild),
          const SizedBox(height: 24),
          Divider(
            color: isDark ? const Color(0xff21262D) : const Color(0xffF1F5F9),
            thickness: 1.5,
          ),
          const SizedBox(height: 16),
          YesNoQuestion(
            question: "disease_q".tr(),
            showField: uiHandler.showDiseaseField,
            onChanged: uiHandler.updateDisease,
            controller: uiHandler.diseaseController,
            hintText: "disease_enter".tr(),
          ),
          const SizedBox(height: 16),
          YesNoQuestion(
            question: "allergies_q".tr(),
            showField: uiHandler.showAllergyField,
            onChanged: uiHandler.updateAllergy,
            controller: uiHandler.allergyController,
            hintText: "allergies_enter".tr(),
          ),
          const SizedBox(height: 16),
          YesNoQuestion(
            question: "medication_q".tr(),
            showField: uiHandler.showMedicationField,
            onChanged: uiHandler.updateMedication,
            controller: uiHandler.medicationController,
            hintText: "medication_enter".tr(),
          ),
          const SizedBox(height: 16),
          YesNoQuestion(
            question: "surgery_q".tr(),
            showField: uiHandler.showSurgeryField,
            onChanged: uiHandler.updateSurgery,
            controller: uiHandler.surgeryController,
            hintText: "surgery_enter".tr(),
          ),
          const SizedBox(height: 16),
          YesNoQuestion(
            question: "previous_illnesses_q".tr(),
            showField: uiHandler.showPreviousIllnesses,
            onChanged: uiHandler.updatePreviousIllnesses,
            controller: uiHandler.previousIllnessesController,
            hintText: "previous_illnesses_enter".tr(),
          ),
        ],
      ),
    );
  }
}
