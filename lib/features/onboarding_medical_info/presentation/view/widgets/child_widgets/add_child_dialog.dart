import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/core/widget/custom_text_field.dart';
import 'package:medicore_app/features/main_home/presentation/view/main_home_view.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/widgets/questions.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/Handler%20Questions/children_ui_adapter.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_cubit/children_info_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_ui_cubit/children_info_ui_cubit.dart';

class AddChildDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;

    return Dialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: MediaQuery.of(
                      context,
                    ).viewInsets.add(const EdgeInsets.all(20)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BlocBuilder<ChildrenInfoUiCubit, ChildrenInfoUiState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                CustomTextField(
                                  controller: state.childFirstNameController,
                                  labelText: 'child_first_name'.tr(),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  controller: state.childLastNameController,
                                  labelText: 'child_last_name'.tr(),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 10),

                        BlocBuilder<ChildrenInfoUiCubit, ChildrenInfoUiState>(
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
                  padding: const EdgeInsets.all(20.0),
                  child: BlocConsumer<ChildrenInfoCubit, ChildrenInfoState>(
                    listener: (context, state) {
                      if (state is AddChildSuccess) {
                        context.pop();
                        CustomSnackbar.show(
                          context,
                          message: state.child.message,
                          type: SnackbarType.success,
                        );
                        context.go(MainHomeView.routeName);
                      } else if (state is ChildFailure) {
                        CustomSnackbar.show(
                          context,
                          message: state.error,
                          type: SnackbarType.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AddChildLoading) {
                        return CircularProgressIndicator(
                          color: theme.primaryColor,
                        );
                      }
                      return CustomButton(
                        title: 'add_child'.tr(),
                        onTap: () {
                          final childState =
                              context.read<ChildrenInfoUiCubit>().state;
                          final birthDate =
                              childState.birthDate != null
                                  ? DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(childState.birthDate!)
                                  : null;
                          final childFirstName =
                              context
                                  .read<ChildrenInfoUiCubit>()
                                  .state
                                  .childFirstNameController
                                  .text
                                  .trim();
                          final childLastName =
                              context
                                  .read<ChildrenInfoUiCubit>()
                                  .state
                                  .childLastNameController
                                  .text
                                  .trim();
                          if (childFirstName.isEmpty || birthDate == null) {
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
                                childState.diseaseController.text.trim(),
                            'medication_allergies':
                                childState.allergyController.text.trim(),
                            'permanent_medications':
                                childState.medicationController.text.trim(),
                            'previous_surgeries':
                                childState.surgeryController.text.trim(),
                            'previous_illnesses':
                                childState.previousIllnessesController.text
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
    );
  }
}
