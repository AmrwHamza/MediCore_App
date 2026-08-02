import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';

import '../../../view_model/edit_profile_cubit/edit_profile_cubit.dart';
import '../creative_medical_background.dart';
import 'edit_profile_form.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return CreativeMedicalBackground(
      theme: theme,
      child: BlocListener<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          state.maybeWhen(
            EditSuccess: (profile) {
              context.pop();
              CustomSnackbar.show(
                context,
                message: 'edit_patient_profile_success'.tr(),
                type: SnackbarType.success,
              );
            },
            error: (message) {
              CustomSnackbar.show(
                context,
                message: message,
                type: SnackbarType.error,
              );
            },
            orElse: () {},
          );
        },
        child: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading:
                  () => const Center(
                    child: CircularProgressIndicator(color: Colors.cyanAccent),
                  ),
              error:
                  (message) => Center(
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
              success: (profile) => EditProfileForm(profile: profile),
              EditSuccess: (profile) => EditProfileForm(profile: profile),
            );
          },
        ),
      ),
    );
  }
}
