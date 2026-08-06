import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_form_field.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/otp_view.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view/widget/custom_phone_field.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view_model/create_account_cubit/create_account_cubit.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view_model/id_cubit/id_cubit.dart';
import 'package:medicore_app/features/auth/public_cubits/auth_validate_cubit/auth_validate_cubit.dart';
import 'package:medicore_app/features/auth/public_cubits/auth_validate_cubit/auth_validate_state.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CreateAccountBody extends StatefulWidget {
  const CreateAccountBody({super.key});

  @override
  State<CreateAccountBody> createState() => _CreateAccountBodyState();
}

class _CreateAccountBodyState extends State<CreateAccountBody> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? password;
  String? confPassword;
  String id = '';

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<CreateAccountCubit>().createAccount(
        firstName: firstName!,
        lastName: lastName!,
        email: email!,
        phoneNumber: phoneNumber!,
        password: password!,
        confPassword: confPassword!,
        id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthValidateCubit>();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? KSurfaceDark : KSurfaceLight;
    final textPrimary = isDark ? KTextPrimaryDark : KTextPrimaryLight;
    final textSecondary = isDark ? KTextSecondaryDark : KTextSecondaryLight;
    final borderColor = isDark ? KBorderDark : KBorderLight;

    return BlocConsumer<CreateAccountCubit, CreateAccountState>(
      listener: (context, state) {
        if (state is CreateAccountFailure) {
          CustomSnackbar.show(
            context,
            message: state.message,
            type: SnackbarType.error,
          );
        } else if (state is CreateAccountSuccess) {
          context.goNamed(
            OTPView.routeName,
            extra: {"isForgetPassword": false},
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is CreateAccountLoading ? true : false,
          child: Stack(
            children: [
              Positioned(
                top: -100,
                right: -50,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        KPrimaryColor.withValues(alpha: 0.2),
                        KPrimaryColor.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                left: -80,
                child: Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        KCyan.withValues(alpha: 0.15),
                        KCyan.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    KPrimaryDark,
                                    KPrimaryColor,
                                    KPrimaryLight,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: KPrimaryColor.withValues(alpha: 0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.person_add_rounded,
                                color: Colors.white,
                                size: 38,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'create_account_title'.tr(),
                              style: TextStyles.H1.copyWith(
                                color: textPrimary,
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'create_account_desc'.tr(),
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            Container(
                              decoration: BoxDecoration(
                                color: surfaceColor.withValues(alpha: 0.75),
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                  color: borderColor,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(
                                      alpha: isDark ? 0.2 : 0.04,
                                    ),
                                    blurRadius: 32,
                                    offset: const Offset(0, 16),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(32),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 16,
                                    sigmaY: 16,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 24.0,
                                      horizontal: 8,
                                    ),
                                    child: Column(
                                      children: [
                                        CustomFormField(
                                          label: 'first_name_hint'.tr(),
                                          icon: Icons.person_outline_rounded,
                                          keyboardType: TextInputType.text,
                                          focusNode: _firstNameFocusNode,
                                          textInputAction: TextInputAction.next,
                                          validator: cubit.validateName,
                                          onChanged: (val) {
                                            firstName = val.trim();
                                          },
                                          onFieldSubmitted: (_) {
                                            _lastNameFocusNode.requestFocus();
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        CustomFormField(
                                          label: 'last_name_hint'.tr(),
                                          icon: Icons.person_outline_rounded,
                                          keyboardType: TextInputType.text,
                                          focusNode: _lastNameFocusNode,
                                          textInputAction: TextInputAction.next,
                                          validator: cubit.validateName,
                                          onChanged: (val) {
                                            lastName = val.trim();
                                          },
                                          onFieldSubmitted: (_) {
                                            _emailFocusNode.requestFocus();
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        CustomFormField(
                                          label: 'email_hint'.tr(),
                                          icon: Icons.email_outlined,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          focusNode: _emailFocusNode,
                                          textInputAction: TextInputAction.next,
                                          validator: cubit.validateEmail,
                                          onChanged: (value) {
                                            cubit.email = value;
                                            email = value.trim();
                                          },
                                          onFieldSubmitted: (_) {
                                            _phoneFocusNode.requestFocus();
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        CustomPhoneField(
                                          label: 'phone_hint'.tr(),
                                          focusNode: _phoneFocusNode,
                                          textInputAction: TextInputAction.next,
                                          onChanged: (val) {
                                            cubit.phone = val;
                                            phoneNumber = val.trim();
                                          },
                                          validator: cubit.validatePhone,
                                          onFieldSubmitted: (_) {
                                            _passwordFocusNode.requestFocus();
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        BlocBuilder<
                                          AuthValidateCubit,
                                          AuthValidateState
                                        >(
                                          buildWhen:
                                              (previous, current) =>
                                                  current
                                                      is ChangePasswordObscure,
                                          builder: (context, state) {
                                            final cubit =
                                                context
                                                    .read<AuthValidateCubit>();
                                            return CustomFormField(
                                              label: 'password_hint'.tr(),
                                              icon: Icons.lock_outline_rounded,
                                              isPassword: true,
                                              obscure: cubit.obscurePassword,
                                              focusNode: _passwordFocusNode,
                                              textInputAction:
                                                  TextInputAction.next,
                                              pressOnEye:
                                                  cubit.changeObscurePassword,
                                              validator:
                                                  cubit.validateNewPassword,
                                              onChanged: (value) {
                                                cubit.password = value.trim();
                                                password = value.trim();
                                              },
                                              onFieldSubmitted: (_) {
                                                _confirmPasswordFocusNode
                                                    .requestFocus();
                                              },
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        BlocBuilder<
                                          AuthValidateCubit,
                                          AuthValidateState
                                        >(
                                          buildWhen:
                                              (previous, current) =>
                                                  current
                                                      is ChangeConfirmPasswordObscure,
                                          builder: (context, state) {
                                            final cubit =
                                                context
                                                    .read<AuthValidateCubit>();
                                            return CustomFormField(
                                              label:
                                                  'confirm_password_hint'.tr(),
                                              icon: Icons.lock_outline_rounded,
                                              isPassword: true,
                                              obscure:
                                                  cubit.obscureConfirmPassword,
                                              focusNode:
                                                  _confirmPasswordFocusNode,
                                              textInputAction:
                                                  TextInputAction.done,
                                              pressOnEye:
                                                  cubit
                                                      .changeObscureConfirmPassword,
                                              validator:
                                                  cubit.validatePasswordMatch,
                                              onChanged: (value) {
                                                cubit.confirmPassword =
                                                    value.trim();
                                                confPassword = value.trim();
                                              },
                                              onFieldSubmitted: (_) =>
                                                  _submit(),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                        BlocBuilder<IdCubit, IdState>(
                                          builder: (context, state) {
                                            final hasID =
                                                state is IsHasID &&
                                                state.isHasID;
                                            return Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: borderColor.withValues(
                                                  alpha: 0.2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: borderColor,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          'id_question2'.tr() +
                                                              " " +
                                                              'id_question'
                                                                  .tr(),
                                                          style: TextStyle(
                                                            color: textPrimary,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 12),
                                                      Switch.adaptive(
                                                        activeColor:
                                                            KPrimaryColor,
                                                        value: hasID,
                                                        onChanged: (value) {
                                                          context
                                                              .read<IdCubit>()
                                                              .showQeustion(
                                                                isHasID: value,
                                                              );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  if (hasID) ...[
                                                    const SizedBox(height: 14),
                                                    CustomFormField(
                                                      label: 'ID_hint'.tr(),
                                                      icon:
                                                          Icons
                                                              .credit_card_rounded,
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      onChanged:
                                                          (value) =>
                                                              id = value.trim(),
                                                      onFieldSubmitted: (_) =>
                                                          _submit(),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 28),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                KPrimaryDark,
                                                KPrimaryColor,
                                                KPrimaryLight,
                                              ],
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: KPrimaryColor.withValues(
                                                  alpha: 0.3,
                                                ),
                                                blurRadius: 16,
                                                offset: const Offset(0, 8),
                                              ),
                                            ],
                                          ),
                                          child: CustomButton(
                                            title: 'create_account_btn'.tr(),
                                            onTap: _submit,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
