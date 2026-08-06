import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/family/presentation/view_model/edit_child_cubit/edit_child_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/get_child_entity.dart';

class ChildProfileTab extends StatelessWidget {
  final GetChildEntity child;
  final ValueChanged<GetChildEntity>? onChildUpdated;

  const ChildProfileTab({super.key, required this.child, this.onChildUpdated});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => EditChildCubit(),
      child: BlocListener<EditChildCubit, EditChildState>(
        listener: (context, state) {
          state.when(
            success: (updatedChild) {
              onChildUpdated?.call(updatedChild);
              CustomSnackbar.show(
                context,
                message: 'child_profile_updated'.tr(),
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
            initial: () {},
            loading: () {},
          );
        },
        child: ListView(
          padding: EdgeInsets.all(20.w),
          children: [
            ChildSectionHeader(title: 'health_profile'.tr(), isDark: isDark),
            SizedBox(height: 12.h),
            ChildConsolidatedInfoCard(child: child, isDark: isDark),
            SizedBox(height: 20.h),
            ChildEditProfileButton(child: child, isDark: isDark),
          ],
        ),
      ),
    );
  }
}

class ChildSectionHeader extends StatelessWidget {
  final String title;
  final bool isDark;

  const ChildSectionHeader({
    super.key,
    required this.title,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: KPrimaryColor,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          title,
          style: TextStyles.H2.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : KDarkBlue,
          ),
        ),
      ],
    );
  }
}

class ChildConsolidatedInfoCard extends StatelessWidget {
  final GetChildEntity child;
  final bool isDark;

  const ChildConsolidatedInfoCard({
    super.key,
    required this.child,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? KCardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color:
              isDark
                  ? KBorderDark.withValues(alpha: 0.4)
                  : Colors.grey.withValues(alpha: 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.1 : 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ChildInfoRow(
            icon: Icons.person_outline,
            label: 'name'.tr(),
            value: '${child.firstName} ${child.lastName}',
            isDark: isDark,
          ),
          _buildDivider(isDark),
          ChildInfoRow(
            icon: Icons.cake_outlined,
            label: 'birthdate'.tr(),
            value: child.birthDate,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          ChildInfoRow(
            icon: Icons.transgender_outlined,
            label: 'gender'.tr(),
            value: child.gender.tr(),
            isDark: isDark,
          ),
          _buildDivider(isDark),
          ChildInfoRow(
            icon: Icons.bloodtype_outlined,
            label: 'blood_type'.tr(),
            value:
                child.bloodType?.isNotEmpty == true ? child.bloodType! : 'N/A',
            isDark: isDark,
          ),
          _buildDivider(isDark),
          ChildInfoRow(
            icon: Icons.person_outline,
            label: 'age'.tr(),
            value: '${child.age} ${'years'.tr()}',
            isDark: isDark,
          ),
          _buildDivider(isDark),
          ChildInfoRow(
            icon: Icons.fingerprint_outlined,
            label: 'patient_id'.tr(),
            value: '${child.patientId}',
            isDark: isDark,
          ),
          _buildDivider(isDark),
          ChildInfoRow(
            icon: Icons.badge_outlined,
            label: 'child_id'.tr(),
            value: '${child.id}',
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1.h,
      thickness: 1.h,
      color:
          isDark
              ? KBorderDark.withValues(alpha: 0.3)
              : Colors.grey.withValues(alpha: 0.1),
    );
  }
}

class ChildInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isDark;

  const ChildInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: KPrimaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: KPrimaryColor, size: 18.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color:
                        isDark
                            ? Colors.white.withValues(alpha: 0.5)
                            : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : KDarkBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChildEditProfileButton extends StatelessWidget {
  final GetChildEntity child;
  final bool isDark;

  const ChildEditProfileButton({
    super.key,
    required this.child,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditChildCubit, EditChildState>(
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton.icon(
            onPressed: isLoading ? null : () => _showEditDialog(context, child),
            icon:
                isLoading
                    ? SizedBox(
                      width: 20.r,
                      height: 20.r,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                    : Icon(Icons.edit_outlined, size: 20.r),
            label: Text(
              isLoading ? 'updating'.tr() : 'edit_profile'.tr(),
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: KPrimaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
          ),
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, GetChildEntity child) {
    final editChildCubit = context.read<EditChildCubit>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      builder: (_) => _ChildEditSheet(
        child: child,
        isDark: isDark,
        cubit: editChildCubit,
      ),
    );
  }
}

class _ChildEditSheet extends StatefulWidget {
  final GetChildEntity child;
  final bool isDark;
  final EditChildCubit cubit;

  const _ChildEditSheet({
    required this.child,
    required this.isDark,
    required this.cubit,
  });

  @override
  State<_ChildEditSheet> createState() => _ChildEditSheetState();
}

class _ChildEditSheetState extends State<_ChildEditSheet> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _ageController;
  late String _selectedGender;
  late String _selectedBloodType;

  static const _bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.child.firstName);
    _lastNameController = TextEditingController(text: widget.child.lastName);
    _birthDateController = TextEditingController(text: widget.child.birthDate);
    _ageController = TextEditingController(text: widget.child.age.toString());
    _selectedGender = widget.child.gender;
    _selectedBloodType = widget.child.bloodType ?? 'A+';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _pickBirthDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          DateTime.tryParse(_birthDateController.text) ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) {
      setState(() {
        _birthDateController.text =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  void _save() {
    final age = int.tryParse(_ageController.text) ?? widget.child.age;
    widget.cubit.updateChild(
      childId: widget.child.id,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      birthDate: _birthDateController.text,
      gender: _selectedGender,
      age: age,
      bloodType: _selectedBloodType,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final surfaceColor = isDark ? KSurfaceDark : Colors.white;
    final textColor = isDark ? KTextPrimaryDark : KTextPrimaryLight;
    final mutedColor = isDark ? KTextSecondaryDark : KTextSecondaryLight;

    return BlocProvider.value(
      value: widget.cubit,
      child: BlocListener<EditChildCubit, EditChildState>(
        listener: (context, state) {
          state.when(
            success: (_) => Navigator.of(context).pop(),
            failure: (_) {},
            initial: () {},
            loading: () {},
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 24,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(
            20.w,
            16.h,
            20.w,
            20.h + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: isDark ? KBorderDark : KDividerLight,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Row(
                children: [
                  Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [KPrimaryColor, KPrimaryDark],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: KPrimaryColor.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.child_care_rounded,
                      color: Colors.white,
                      size: 24.r,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'edit_child_profile'.tr(),
                      style: TextStyles.H2.copyWith(
                        color: textColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: mutedColor,
                      size: 22.r,
                    ),
                    tooltip: 'close'.tr(),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Divider(color: isDark ? KBorderDark : KDividerLight),
              SizedBox(height: 8.h),
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _ChildFormField(
                        controller: _firstNameController,
                        label: 'first_name'.tr(),
                        icon: Icons.person_outline_rounded,
                        isDark: isDark,
                      ),
                      SizedBox(height: 12.h),
                      _ChildFormField(
                        controller: _lastNameController,
                        label: 'last_name'.tr(),
                        icon: Icons.person_outline_rounded,
                        isDark: isDark,
                      ),
                      SizedBox(height: 12.h),
                      _ChildFormField(
                        controller: _birthDateController,
                        label: 'birth_date'.tr(),
                        icon: Icons.calendar_today_rounded,
                        isDark: isDark,
                        readOnly: true,
                        onTap: _pickBirthDate,
                      ),
                      SizedBox(height: 12.h),
                      _ChildDropdownField(
                        value:
                            ['male', 'female'].contains(
                              _selectedGender.toLowerCase(),
                            )
                            ? _selectedGender.toLowerCase()
                            : 'male',
                        items: ['male', 'female'],
                        label: 'gender'.tr(),
                        icon: Icons.transgender_rounded,
                        isDark: isDark,
                        onChanged: (value) {
                          if (value != null) _selectedGender = value;
                        },
                      ),
                      SizedBox(height: 12.h),
                      _ChildFormField(
                        controller: _ageController,
                        label: 'age'.tr(),
                        icon: Icons.onetwothree_rounded,
                        isDark: isDark,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 12.h),
                      _ChildDropdownField(
                        value: _bloodTypes.contains(_selectedBloodType)
                            ? _selectedBloodType
                            : 'A+',
                        items: _bloodTypes,
                        label: 'blood_type'.tr(),
                        icon: Icons.bloodtype_rounded,
                        isDark: isDark,
                        onChanged: (value) {
                          if (value != null) _selectedBloodType = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: BlocBuilder<EditChildCubit, EditChildState>(
                  builder: (context, state) {
                    final isLoading = state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );
                    return ElevatedButton(
                      onPressed: isLoading ? null : _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: KPrimaryColor,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: KPrimaryColor.withValues(
                          alpha: 0.5,
                        ),
                        elevation: 4,
                        shadowColor: KPrimaryColor.withValues(alpha: 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: isLoading
                          ? SizedBox(
                              width: 22.r,
                              height: 22.r,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2.4,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'save'.tr(),
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChildFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isDark;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;

  const _ChildFormField({
    required this.controller,
    required this.label,
    required this.icon,
    required this.isDark,
    this.readOnly = false,
    this.onTap,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark ? KBorderDark : KBorderLight;
    final textColor = isDark ? KTextPrimaryDark : KTextPrimaryLight;
    final fillColor = isDark ? KCardDark : KSurfaceLight;

    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      style: TextStyle(color: textColor, fontSize: 14.sp),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: isDark ? KTextSecondaryDark : KGrey),
        prefixIcon: Icon(icon, color: KPrimaryColor, size: 20.r),
        filled: true,
        fillColor: fillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: KPrimaryColor, width: 1.8),
        ),
      ),
    );
  }
}

class _ChildDropdownField extends StatelessWidget {
  final String value;
  final List<String> items;
  final String label;
  final IconData icon;
  final bool isDark;
  final ValueChanged<String?> onChanged;

  const _ChildDropdownField({
    required this.value,
    required this.items,
    required this.label,
    required this.icon,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final dropdownBg = isDark ? KCardDark : KSurfaceLight;
    final fieldTextColor = isDark ? KTextPrimaryDark : KTextPrimaryLight;
    final fieldBorderColor = isDark ? KBorderDark : KBorderLight;

    return DropdownButtonFormField<String>(
      initialValue: value,
      dropdownColor: dropdownBg,
      menuMaxHeight: 320.h,
      style: TextStyle(color: fieldTextColor, fontSize: 14.sp),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: isDark ? KTextSecondaryDark : KGrey),
        prefixIcon: Icon(icon, color: KPrimaryColor, size: 20.r),
        filled: true,
        fillColor: dropdownBg,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: fieldBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: KPrimaryColor, width: 1.8),
        ),
      ),
      items:
          items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item == 'male' || item == 'female' ? item.tr() : item,
                    style: TextStyle(color: fieldTextColor),
                  ),
                ),
              )
              .toList(),
      onChanged: onChanged,
    );
  }
}
