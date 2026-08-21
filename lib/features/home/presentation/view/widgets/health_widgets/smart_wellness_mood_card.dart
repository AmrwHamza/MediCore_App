import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/home/presentation/view_model/patient_wellness_algorithm.dart';

class SmartWellnessMoodCard extends StatefulWidget {

  final int upcomingAppointments;

  final int completedAppointments;

  const SmartWellnessMoodCard({
    super.key,
    required this.upcomingAppointments,
    required this.completedAppointments,
  });

  @override
  State<SmartWellnessMoodCard> createState() => _SmartWellnessMoodCardState();
}

class _SmartWellnessMoodCardState extends State<SmartWellnessMoodCard> {
  final _algorithm = const PatientWellnessAlgorithm();
  double? _bmi;
  int _medicalProfileFields = 0;

  @override
  void initState() {
    super.initState();
    _loadLocalData();
  }

  Future<void> _loadLocalData() async {
    final height = await SharedPrefHelper.getData(SharedPrefKeys.bmiHeight);
    final weight = await SharedPrefHelper.getData(SharedPrefKeys.bmiWeight);
    final fields = await _countMedicalProfileFields();
    if (!mounted) return;

    double? bmi;
    if (height is double && weight is double && height > 0) {
      final h = height / 100;
      bmi = weight / (h * h);
    }

    setState(() {
      _bmi = bmi;
      _medicalProfileFields = fields;
    });
  }

  Future<int> _countMedicalProfileFields() async {
    const keys = [
      SharedPrefKeys.birthDate,
      SharedPrefKeys.gender,
      SharedPrefKeys.bloodType,
      SharedPrefKeys.medicationAllergies,
      SharedPrefKeys.chronicDiseases,
      SharedPrefKeys.permanentMedications,
      SharedPrefKeys.previousSurgeries,
      SharedPrefKeys.previousIllnesses,
    ];
    var count = 0;
    for (final key in keys) {
      final value = await SharedPrefHelper.getData(key);
      if (value is String && value.trim().isNotEmpty) count++;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : KBlack;
    final mutedColor = isDark
        ? Colors.white.withValues(alpha: 0.6)
        : Colors.grey[600] ?? Colors.grey;
    final surfaceColor = isDark ? KCardDark : Colors.white;

    final result = _algorithm.compute(
      bmi: _bmi,
      hasUpcomingAppointment: widget.upcomingAppointments > 0,
      hasCompletedAppointment: widget.completedAppointments > 0,
      medicalProfileFields: _medicalProfileFields,
    );
    final moodColor = result.mood.color;
    final score = result.score / 100;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? KBorderDark : Colors.grey.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: moodColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(result.mood.icon, color: moodColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'wellness_title'.tr(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: moodColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: moodColor.withValues(alpha: 0.25)),
                ),
                child: Text(
                  result.mood.titleKey.tr(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: moodColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width: 110,
                height: 110,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 110,
                      height: 110,
                      child: CircularProgressIndicator(
                        value: score,
                        strokeWidth: 10,
                        strokeCap: StrokeCap.round,
                        backgroundColor: moodColor.withValues(alpha: 0.12),
                        valueColor: AlwaysStoppedAnimation(moodColor),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${result.score}',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'wellness_out_of_100'.tr(),
                          style: TextStyle(fontSize: 10, color: mutedColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  children: [
                    _buildContributionBar(
                      icon: Icons.event_available_rounded,
                      labelKey: 'wellness_factor_appointments',
                      value: result.appointmentScore,
                      max: 40,
                      color: KPrimaryColor,
                      mutedColor: mutedColor,
                    ),
                    const SizedBox(height: 12),
                    _buildContributionBar(
                      icon: Icons.folder_shared_rounded,
                      labelKey: 'wellness_factor_medical_log',
                      value: result.careScore,
                      max: 30,
                      color: KInfo,
                      mutedColor: mutedColor,
                    ),
                    const SizedBox(height: 12),
                    _buildContributionBar(
                      icon: Icons.monitor_weight_outlined,
                      labelKey: 'wellness_factor_bmi',
                      value: result.bmiScore,
                      max: 30,
                      color: KSuccess,
                      mutedColor: mutedColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: moodColor.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: moodColor.withValues(alpha: 0.15)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline_rounded, color: moodColor, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    result.mood.tipKey.tr(),
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.4,
                      color: textColor.withValues(alpha: 0.85),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContributionBar({
    required IconData icon,
    required String labelKey,
    required int value,
    required int max,
    required Color color,
    required Color mutedColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    labelKey.tr(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: mutedColor,
                    ),
                  ),
                  Text(
                    '$value/$max',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: max == 0 ? 0 : value / max,
                  minHeight: 5,
                  backgroundColor: color.withValues(alpha: 0.12),
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
