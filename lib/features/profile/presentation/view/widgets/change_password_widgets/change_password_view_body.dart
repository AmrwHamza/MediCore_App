import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

import '../../../../../../core/widget/custom_snack_bar.dart';
import '../../../view_model/cubit/change_password_cubit.dart';
import 'change_password_form.dart';
import '../creative_medical_background.dart';

// ignore: must_be_immutable
class ChangePasswordViewBody extends StatelessWidget {
  ChangePasswordViewBody({super.key});

  String? oldPassword;
  String? newPassword;
  String? confirmPassword;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return CreativeMedicalBackground(
      theme: theme,
      child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (message) {
              context.pop();
              CustomSnackbar.show(
                context,
                message: message,
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
        child: const ChangePasswordForm(),
      ),
    );
  }
}
