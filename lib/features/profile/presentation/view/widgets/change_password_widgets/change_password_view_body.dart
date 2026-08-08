import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';

import '../../../view_model/cubit/change_password_cubit.dart';
import 'change_password_form.dart';

class ChangePasswordViewBody extends StatelessWidget {
  const ChangePasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
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
    );
  }
}
