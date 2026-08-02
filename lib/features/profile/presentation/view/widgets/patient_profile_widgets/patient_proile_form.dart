import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/core/widget/custom_form_field.dart';
import 'package:medicore_app/features/profile/domain/entities/patient_profile_entity.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/patient_profile_widgets/blood_type_selector.dart';
import 'package:medicore_app/features/profile/presentation/view/widgets/patient_profile_widgets/gender_selector.dart';
import 'package:medicore_app/features/profile/presentation/view_model/edit_patient_profile_cubit/edit_patient_profile_cubit.dart';

class PatientProfileForm extends StatefulWidget {
  final PatientProfileEntity profile;

  const PatientProfileForm({super.key, required this.profile});

  @override
  State<PatientProfileForm> createState() => _PatientProfileFormState();
}

class _PatientProfileFormState extends State<PatientProfileForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController birthDateController;
  late TextEditingController ageController;
  late TextEditingController allergiesController;
  late TextEditingController chronicController;
  late TextEditingController medicationsController;
  late TextEditingController surgeriesController;
  late TextEditingController illnessesController;

  String? _selectedGender;
  String? _selectedBloodType;
  bool _isEditable = false;

  @override
  void initState() {
    super.initState();
    birthDateController = TextEditingController(text: widget.profile.birthDate);
    ageController = TextEditingController(text: widget.profile.age.toString());
    allergiesController = TextEditingController(
      text: widget.profile.medicationAllergies,
    );
    chronicController = TextEditingController(
      text: widget.profile.chronicDiseases,
    );
    medicationsController = TextEditingController(
      text: widget.profile.permanentMedications,
    );
    surgeriesController = TextEditingController(
      text: widget.profile.previousSurgeries,
    );
    illnessesController = TextEditingController(
      text: widget.profile.previousIllnesses,
    );
    _selectedGender = widget.profile.gender.toLowerCase();
    _selectedBloodType = widget.profile.bloodType;
  }

  @override
  void dispose() {
    birthDateController.dispose();
    ageController.dispose();
    allergiesController.dispose();
    chronicController.dispose();
    medicationsController.dispose();
    surgeriesController.dispose();
    illnessesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'editing_mode'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Switch(
                    activeThumbColor: Colors.white,
                    activeTrackColor: KPrimaryColor,
                    inactiveThumbColor: Colors.grey[400],
                    inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
                    value: _isEditable,
                    onChanged: (value) {
                      setState(() {
                        _isEditable = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TabBar(
              tabs: [
                Tab(text: 'bio_info'.tr(), icon: const Icon(Icons.badge)),
                Tab(
                  text: 'medical_history'.tr(),
                  icon: const Icon(Icons.health_and_safety),
                ),
              ],
              labelColor: KPrimaryColor,
              unselectedLabelColor: Colors.white60,
              indicatorColor: Colors.cyanAccent,
              dividerColor: Colors.transparent,
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [_buildBioTab(), _buildMedicalTab()],
                ),
              ),
            ),
            if (_isEditable)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                child: CustomButton(
                  title: 'save_medical_data'.tr(),
                  color: KDarkBlue.withValues(alpha: 0.85),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<EditPatientProfileCubit>()
                          .updatePatientProfileInfo(
                            birthDate: birthDateController.text,
                            gender: _selectedGender,
                            age: ageController.text,
                            bloodType: _selectedBloodType,
                            medicationAllergies: allergiesController.text,
                            chronicDiseases: chronicController.text,
                            permanentMedications: medicationsController.text,
                            previousSurgeries: surgeriesController.text,
                            previousIllnesses: illnessesController.text,
                          );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBioTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'gender'.tr(),
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 10),
            GenderSelector(
              selectedGender: _selectedGender,
              enabled: _isEditable,
              onChanged: (gender) => setState(() => _selectedGender = gender),
            ),
            const SizedBox(height: 25),
            Text(
              'blood_type'.tr(),
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 10),
            BloodTypeSelector(
              selectedType: _selectedBloodType,
              enabled: _isEditable,
              onChanged: (type) => setState(() => _selectedBloodType = type),
            ),
            const SizedBox(height: 25),
            CustomFormField(
              controller: birthDateController,
              enabled: _isEditable,
              label: 'birth_date'.tr(),
              icon: Icons.calendar_today,
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 16),
            CustomFormField(
              controller: ageController,
              enabled: _isEditable,
              label: 'age'.tr(),
              icon: Icons.onetwothree,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Column(
          children: [
            CustomFormField(
              controller: allergiesController,
              enabled: _isEditable,
              label: 'medication_allergies'.tr(),
              icon: Icons.warning_amber_rounded,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 16),
            CustomFormField(
              controller: chronicController,
              enabled: _isEditable,
              label: 'chronic_diseases'.tr(),
              icon: Icons.healing,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 16),
            CustomFormField(
              controller: medicationsController,
              enabled: _isEditable,
              label: 'permanent_medications'.tr(),
              icon: Icons.medication,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 16),
            CustomFormField(
              controller: surgeriesController,
              enabled: _isEditable,
              label: 'previous_surgeries'.tr(),
              icon: Icons.personal_injury,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 16),
            CustomFormField(
              controller: illnessesController,
              enabled: _isEditable,
              label: 'previous_illnesses'.tr(),
              icon: Icons.sick,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
    );
  }
}
