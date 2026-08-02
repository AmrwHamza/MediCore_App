import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/questions.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/Handler%20Questions/children_ui_adapter.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_cubit/children_info_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_ui_cubit/children_info_ui_cubit.dart';

import '../../../../../../core/widget/custom_form_field.dart';

class AddChildDialog extends StatelessWidget {
  const AddChildDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = isDark ? KPrimaryColor : KPrimaryDark;
    final cardBg = isDark ? const Color(0xff1A202C) : Colors.white;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: CustomPaint(
              painter: BackgroundShapesPainter(
                brandColor: primaryColor.withValues(
                  alpha: isDark ? 0.07 : 0.04,
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.85,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            left: 24,
                            right: 24,
                            bottom: 8,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.child_care_rounded,
                                color: primaryColor,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'add_child'.tr(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: theme.canvasColor,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: theme.canvasColor.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          indent: 24,
                          endIndent: 24,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: MediaQuery.of(context).viewInsets.add(
                              const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: cardBg,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: theme.dividerColor.withValues(
                                        alpha: 0.05,
                                      ),
                                    ),
                                  ),
                                  child: BlocBuilder<
                                    ChildrenInfoUiCubit,
                                    ChildrenInfoUiState
                                  >(
                                    builder: (context, state) {
                                      return Column(
                                        children: [
                                          CustomFormField(
                                            controller:
                                                state.childFirstNameController,
                                            label: 'child_first_name'.tr(),
                                            icon: Icons.person_2_outlined,
                                          ),
                                          const SizedBox(height: 16),
                                          CustomFormField(
                                            controller:
                                                state.childLastNameController,
                                            label: 'child_last_name'.tr(),
                                            icon: Icons.person_2_outlined,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                                BlocBuilder<
                                  ChildrenInfoUiCubit,
                                  ChildrenInfoUiState
                                >(
                                  builder: (context, childState) {
                                    final childCubit =
                                        context.read<ChildrenInfoUiCubit>();
                                    return Questions(
                                      isChild: true,
                                      uiHandler: ChildrenUiAdapter(
                                        childCubit,
                                        childState,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: BlocConsumer<
                            ChildrenInfoCubit,
                            ChildrenInfoState
                          >(
                            listener: (context, state) {
                              if (state is ChildFailure) {
                                CustomSnackbar.show(
                                  context,
                                  message: state.error,
                                  type: SnackbarType.error,
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is AddChildLoading) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                );
                              }
                              return CustomButton(
                                title: 'add_child'.tr(),
                                onTap: () {
                                  final childUiCubit =
                                      context.read<ChildrenInfoUiCubit>();
                                  final childState = childUiCubit.state;

                                  final birthDate =
                                      childState.birthDate != null
                                          ? DateFormat(
                                            'yyyy-MM-dd',
                                          ).format(childState.birthDate!)
                                          : null;
                                  final childFirstName =
                                      childState.childFirstNameController.text
                                          .trim();
                                  final childLastName =
                                      childState.childLastNameController.text
                                          .trim();

                                  if (childFirstName.isEmpty ||
                                      birthDate == null) {
                                    CustomSnackbar.show(
                                      context,
                                      message: 'required_fields'.tr(),
                                      type: SnackbarType.warning,
                                    );
                                    return;
                                  }

                                  final data = {
                                    'first_name': childFirstName,
                                    'last_name': childLastName,
                                    'birth_date': birthDate,
                                    'gender': childState.gender,
                                    'age': childState.age,
                                    'blood_type': childState.bloodType,
                                    'chronic_diseases':
                                        childState.diseaseController.text
                                            .trim(),
                                    'medication_allergies':
                                        childState.allergyController.text
                                            .trim(),
                                    'permanent_medications':
                                        childState.medicationController.text
                                            .trim(),
                                    'previous_surgeries':
                                        childState.surgeryController.text
                                            .trim(),
                                    'previous_illnesses':
                                        childState
                                            .previousIllnessesController
                                            .text
                                            .trim(),
                                  };

                                  Navigator.of(context).pop(data);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundShapesPainter extends CustomPainter {
  final Color brandColor;
  BackgroundShapesPainter({required this.brandColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = brandColor
          ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.05),
      size.width * 0.25,
      paint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.05, size.height * 0.75),
      size.width * 0.3,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
