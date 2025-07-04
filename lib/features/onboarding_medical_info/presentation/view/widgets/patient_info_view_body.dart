import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/children_info_view.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/questions.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/Handler%20Questions/patient_ui_adapter.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/patient_info_cubit/patient_info_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/patient_info_ui_cubit/patient_info_ui_cubit.dart';

class PatientInfoViewBody extends StatelessWidget {
  const PatientInfoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(Assets.imagesWelcomeDoctor),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      "welcome".tr(),
                      style: TextStyles.H1.copyWith(color: theme.canvasColor),
                    ),
                    Text(
                      "welcome_desc1".tr(),
                      maxLines: null,
                      softWrap: true,
                      style: TextStyles.public.copyWith(
                        color: theme.canvasColor,
                      ),
                    ),
                    Text(
                      "welcome_desc2".tr(),
                      maxLines: null,
                      softWrap: true,
                      style: TextStyles.public.copyWith(
                        color: theme.canvasColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          BlocBuilder<PatientInfoUiCubit, PatientInfoUiState>(
            builder: (context, patientState) {
              final patientCubit = context.read<PatientInfoUiCubit>();
              return Questions(
                isChild: false,
                uiHandler: PatientUiAdapter(patientCubit, patientState),
              );
            },
          ),
          const SizedBox(height: 30),
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
                return const SpinKitThreeBounce(color: KPrimaryColor);
              }
              return CustomButton(
                title: 'next'.tr(),
                onTap: () {
                  final medicalState = context.read<PatientInfoUiCubit>().state;
                  final birthDate =
                      medicalState.birthDate != null
                          ? DateFormat(
                            'yyyy-MM-dd',
                          ).format(medicalState.birthDate!)
                          : null;
                  if (birthDate == null) {
                    CustomSnackbar.show(
                      context,
                      message: 'Please fill all required fields.',
                      type: SnackbarType.warning,
                    );
                    return;
                  }

                  final data = {
                    'birth_date': birthDate,
                    'gender': medicalState.gender,
                    'age': medicalState.age,
                    'blood_type': medicalState.bloodType,
                    'chronic_diseases':
                        medicalState.diseaseController.text.trim(),

                    'medication_allergies':
                        medicalState.allergyController.text.trim(),
                    'permanent_medications':
                        medicalState.medicationController.text.trim(),

                    'previous_surgeries':
                        medicalState.surgeryController.text.trim(),

                    'previous_illnesses':
                        medicalState.previousIllnessesController.text.trim(),
                  };
                  print('⏩⏩⏩⏩⏩ $data');

                  context.read<PatientInfoCubit>().addPatientInfo(data);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
