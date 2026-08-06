import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_form_field.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view/widget/custom_phone_field.dart';
import 'package:medicore_app/features/profile/domain/entities/edit_profile_entity.dart';

import '../../../view_model/edit_profile_cubit/edit_profile_cubit.dart';
import 'profile_header_card.dart';

class EditProfileForm extends StatefulWidget {
  final EditProfileEntity profile;

  const EditProfileForm({super.key, required this.profile});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  bool _isEditable = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
      text: widget.profile.firstName,
    );
    _lastNameController = TextEditingController(text: widget.profile.lastName);
    _emailController = TextEditingController(text: widget.profile.email);
    _phoneController = TextEditingController(text: widget.profile.phone);

    _firstNameController.addListener(_onTextChanged);
    _lastNameController.addListener(_onTextChanged);
    _emailController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _firstNameController.removeListener(_onTextChanged);
    _lastNameController.removeListener(_onTextChanged);
    _emailController.removeListener(_onTextChanged);
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;
    final modeTextColor = isDark ? KTextPrimaryDark : KTextPrimaryLight;
    final containerColor = isDark ? KSurfaceDark : KWhite;
    final containerBorder = isDark ? KBorderDark : KBorderLight;
    final switchInactive =
        isDark ? KTextSecondaryDark : Colors.grey[300]!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ProfileHeaderCard(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  email: _emailController.text,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Editing Mode'.tr(),
                      style: TextStyle(
                        color: modeTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Switch(
                      activeThumbColor: KPrimaryColor,
                      activeTrackColor: KPrimaryColor.withValues(alpha: 0.4),
                      inactiveThumbColor: isDark ? KDisabledDark : Colors.grey[400],
                      inactiveTrackColor: switchInactive,
                      value: _isEditable,
                      onChanged: (value) {
                        setState(() {
                          _isEditable = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                BlocBuilder<EditProfileCubit, EditProfileState>(
                  builder: (context, state) {
                    final cubit = context.read<EditProfileCubit>();
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: containerBorder),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withValues(alpha: 0.15)
                                : Colors.black.withValues(alpha: 0.05),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CustomFormField(
                            controller: _firstNameController,
                            enabled: _isEditable,
                            label: 'first_name_hint'.tr(),
                            icon: Icons.person_outline,
                            keyboardType: TextInputType.text,
                            validator: cubit.validateName,
                          ),
                          const SizedBox(height: 16),
                          CustomFormField(
                            controller: _lastNameController,
                            enabled: _isEditable,
                            label: 'last_name_hint'.tr(),
                            icon: Icons.person_outline,
                            keyboardType: TextInputType.text,
                            validator: cubit.validateName,
                          ),
                          const SizedBox(height: 16),
                          CustomFormField(
                            controller: _emailController,
                            enabled: _isEditable,
                            label: 'email_hint'.tr(),
                            icon: Icons.mail_outline,
                            keyboardType: TextInputType.emailAddress,
                            validator: cubit.validateEmail,
                          ),
                          const SizedBox(height: 16),
                          CustomPhoneField(
                            controller: _phoneController,
                            enabled: _isEditable,
                            label: 'phone_hint'.tr(),
                            onChanged: (String fullNumber) {},
                            validator: cubit.validatePhone,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 35),
                if (_isEditable)
                  CustomButton(
                    title: 'Save Changes'.tr(),
                    color: KPrimaryColor,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await context
                            .read<EditProfileCubit>()
                            .updateProfileInfo(
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text,
                            );
                      }
                    },
                  ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
