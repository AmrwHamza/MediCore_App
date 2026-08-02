import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/children_info_view.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/questions.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/Handler%20Questions/patient_ui_adapter.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/patient_info_cubit/patient_info_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/patient_info_ui_cubit/patient_info_ui_cubit.dart';

import '../../../../../constants.dart';

class PatientInfoViewBody extends StatelessWidget {
  const PatientInfoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? KPrimaryColor : KPrimaryDark;
    final cardColor = isDark ? const Color(0xff161B22) : Colors.white;
    final textPrimary =
        isDark ? const Color(0xffF9FAFB) : const Color(0xff111827);
    final textSecondary =
        isDark ? const Color(0xff9CA3AF) : const Color(0xff6B7280);

    return Stack(
      children: [
        Positioned(
          top: -120,
          left: -120,
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  primaryColor.withValues(alpha: 0.12),
                  primaryColor.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 250,
          right: -150,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xff06B6D4).withValues(alpha: 0.08),
                  const Color(0xff06B6D4).withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color:
                          isDark
                              ? const Color(0xff30363D)
                              : const Color(0xffE2E8F0),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              primaryColor.withValues(alpha: 0.2),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Image.asset(
                          Assets.imagesWelcomeDoctor,
                          height: 90,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "welcome".tr(),
                              style: TextStyle(
                                color: textPrimary,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "welcome_desc1".tr() + " " + "welcome_desc2".tr(),
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 13,
                                height: 1.4,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                BlocBuilder<PatientInfoUiCubit, PatientInfoUiState>(
                  builder: (context, patientState) {
                    final patientCubit = context.read<PatientInfoUiCubit>();
                    return Questions(
                      isChild: false,
                      uiHandler: PatientUiAdapter(patientCubit, patientState),
                    );
                  },
                ),
                const SizedBox(height: 36),
                BlocConsumer<PatientInfoCubit, PatientInfoState>(
                  listener: (context, state) {
                    if (state is AddPatientInfoSuccess) {
                      CustomSnackbar.show(
                        context,
                        message: state.message,
                        type: SnackbarType.success,
                      );
                      context.pushNamed(ChildrenInfoView.routeName);
                    } else if (state is AddPatientInfoFailure) {
                      CustomSnackbar.show(
                        context,
                        message: state.error,
                        type: SnackbarType.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AddPatientInfoLoading) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: SpinKitThreeBounce(
                            color: primaryColor,
                            size: 32,
                          ),
                        ),
                      );
                    }
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [
                            primaryColor,
                            primaryColor.withValues(alpha: 0.9),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withValues(alpha: 0.35),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: CustomButton(
                        title: 'next'.tr(),
                        onTap: () {
                          final medicalState =
                              context.read<PatientInfoUiCubit>().state;
                          final birthDate =
                              medicalState.birthDate != null
                                  ? DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(medicalState.birthDate!)
                                  : null;
                          if (birthDate == null) {
                            CustomSnackbar.show(
                              context,
                              message: 'fill_required_note'.tr(),
                              type: SnackbarType.warning,
                            );
                            return;
                          }

                          context.read<PatientInfoCubit>().addPatientInfo(
                            birthDate: birthDate,
                            gender: medicalState.gender,
                            age: medicalState.age,
                            bloodType: medicalState.bloodType,
                            chronicDiseases:
                                medicalState.diseaseController.text.trim(),
                            allergyController:
                                medicalState.allergyController.text.trim(),
                            permanentMedications:
                                medicalState.medicationController.text.trim(),
                            previousSurgeries:
                                medicalState.surgeryController.text.trim(),
                            previousIllnesses:
                                medicalState.previousIllnessesController.text
                                    .trim(),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
