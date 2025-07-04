import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/age_card.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/birth_date_card.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/blood_type_card.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/gender_card.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/yes_no_question.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/Handler%20Questions/info_ui_handler.dart';

class Questions extends StatelessWidget {
  final bool isChild;
  final InfoUiHandler uiHandler;

  const Questions({
    super.key,
    required this.isChild,
    required this.uiHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BirthDateCard(isChild: isChild),
        const SizedBox(height: 10),
        AgeCard(isChild: isChild),
        const SizedBox(height: 10),
        BloodTypeCard(isChild: isChild),
        const SizedBox(height: 10),
        GenderCard(isChild: isChild),
        const SizedBox(height: 10),
        YesNoQuestion(
          question: "disease_q".tr(),
          showField: uiHandler.showDiseaseField,
          onChanged: uiHandler.updateDisease,
          controller: uiHandler.diseaseController,
          hintText: "disease_enter".tr(),
        ),
        const SizedBox(height: 10),
        YesNoQuestion(
          question: "allergies_q".tr(),
          showField: uiHandler.showAllergyField,
          onChanged: uiHandler.updateAllergy,
          controller: uiHandler.allergyController,
          hintText: "allergies_enter".tr(),
        ),
        const SizedBox(height: 10),
        YesNoQuestion(
          question: "medication_q".tr(),
          showField: uiHandler.showMedicationField,
          onChanged: uiHandler.updateMedication,
          controller: uiHandler.medicationController,
          hintText: "medication_enter".tr(),
        ),
        const SizedBox(height: 10),
        YesNoQuestion(
          question: "surgery_q".tr(),
          showField: uiHandler.showSurgeryField,
          onChanged: uiHandler.updateSurgery,
          controller: uiHandler.surgeryController,
          hintText: "surgery_enter".tr(),
        ),
        const SizedBox(height: 10),
        YesNoQuestion(
          question: "previous_illnesses_q".tr(),
          showField: uiHandler.showPreviousIllnesses,
          onChanged: uiHandler.updatePreviousIllnesses,
          controller: uiHandler.previousIllnessesController,
          hintText: "previous_illnesses_enter".tr(),
        ),
      ],
    );
  }
}
