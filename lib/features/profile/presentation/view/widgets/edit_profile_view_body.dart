import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_form_field.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view/widget/custom_phone_field.dart';
import 'package:medicore_app/features/profile/presentation/view_model/info_cubit/edit_profile_info_cubit.dart';

// ignore: must_be_immutable
class EditProfileViewBody extends StatelessWidget {
  EditProfileViewBody({super.key});

  final formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.primaryColor, KDarkBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: BlocBuilder<EditProfileInfoCubit, EditProfileInfoState>(
            builder: (context, state) {
              final cubit = context.read<EditProfileInfoCubit>();
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomFormField(
                        label: 'first_name_hint'.tr(),
                        icon: Icons.person_pin,
                        keyboardType: TextInputType.text,
                        validator: cubit.validateName,
                        onChanged: (val) {
                          firstName = val;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomFormField(
                        label: 'last_name_hint'.tr(),
                        icon: Icons.person_pin,
                        keyboardType: TextInputType.text,
                        validator: cubit.validateName,
                        onChanged: (val) {
                          lastName = val;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomFormField(
                        label: 'email_hint'.tr(),
                        icon: Icons.email,

                        keyboardType: TextInputType.emailAddress,
                        validator: cubit.validateEmail,
                        onChanged: (value) {
                          cubit.email = value;
                          email = value;
                        },
                      ),
                      const SizedBox(height: 10),

                      CustomPhoneField(
                        label: 'phone_hint'.tr(),
                        onChanged: (val) {
                          cubit.phone = val;
                          phoneNumber = val;
                        },
                        validator: cubit.validatePhone,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: CustomButton(
                      title: 'submit'.tr(),
                      color: KDarkBlue,
                      onTap: () {
                        if (formKey.currentState!.validate()) {}
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
