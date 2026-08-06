import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/profile/presentation/view_model/edit_patient_profile_cubit/edit_patient_profile_cubit.dart';

import '../../../../../../core/widget/custom_snack_bar.dart';
import 'patient_proile_form.dart';

class PatientProfileViewBody extends StatelessWidget {
  const PatientProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return BlocListener<EditPatientProfileCubit, EditPatientProfileState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (profile) {
            CustomSnackbar.show(
              context,
              message: 'edit_patient_profile_success'.tr(),
              type: SnackbarType.success,
            );
          },
          failure: (message) {
            CustomSnackbar.show(
              context,
              message: message,
              type: SnackbarType.error,
            );
          },
          orElse: () {},
        );
      },
      child: BlocBuilder<EditPatientProfileCubit, EditPatientProfileState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading:
                () => const Center(
                      child: CircularProgressIndicator(color: KPrimaryColor),
                    ),
            failure:
                (message) => Center(
                      child: Text(
                        message,
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    ),
            success: (profile) => PatientProfileForm(profile: profile),
            editSuccess: (profile) => PatientProfileForm(profile: profile),
          );
        },
      ),
    );
  }
}
