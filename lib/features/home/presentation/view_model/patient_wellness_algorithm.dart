import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';

enum WellnessMood {
  excellent,
  good,
  needsAttention;

  Color get color => switch (this) {
        WellnessMood.excellent => KSuccess,
        WellnessMood.good => KPrimaryColor,
        WellnessMood.needsAttention => KWarning,
      };

  IconData get icon => switch (this) {
        WellnessMood.excellent => Icons.sentiment_very_satisfied_rounded,
        WellnessMood.good => Icons.sentiment_satisfied_rounded,
        WellnessMood.needsAttention => Icons.sentiment_dissatisfied_rounded,
      };

  String get titleKey => switch (this) {
        WellnessMood.excellent => 'mood_excellent',
        WellnessMood.good => 'mood_good',
        WellnessMood.needsAttention => 'mood_needs_attention',
      };

  String get tipKey => switch (this) {
        WellnessMood.excellent => 'mood_tip_excellent',
        WellnessMood.good => 'mood_tip_good',
        WellnessMood.needsAttention => 'mood_tip_needs_attention',
      };
}

class WellnessResult {

  final int score;

  final int appointmentScore;

  final int careScore;

  final int bmiScore;

  final WellnessMood mood;

  const WellnessResult({
    required this.score,
    required this.appointmentScore,
    required this.careScore,
    required this.bmiScore,
    required this.mood,
  });
}

class PatientWellnessAlgorithm {
  const PatientWellnessAlgorithm();

  WellnessResult compute({
    required double? bmi,
    required bool hasUpcomingAppointment,
    required bool hasCompletedAppointment,
    required int medicalProfileFields,
  }) {
    final appointmentScore = _appointmentScore(
      hasUpcomingAppointment: hasUpcomingAppointment,
      hasCompletedAppointment: hasCompletedAppointment,
    );
    final careScore = _careScore(medicalProfileFields);
    final bmiScore = _bmiScore(bmi);

    final score = (appointmentScore + careScore + bmiScore).clamp(0, 100);
    final mood = _classify(score);

    return WellnessResult(
      score: score,
      appointmentScore: appointmentScore,
      careScore: careScore,
      bmiScore: bmiScore,
      mood: mood,
    );
  }

  int _appointmentScore({
    required bool hasUpcomingAppointment,
    required bool hasCompletedAppointment,
  }) {
    if (hasUpcomingAppointment) return 40;
    if (hasCompletedAppointment) return 22;
    return 8;
  }

  int _careScore(int medicalProfileFields) {
    final filled = medicalProfileFields.clamp(0, 8);
    if (filled == 0) return 6;
    return ((filled / 8) * 30).round().clamp(6, 30);
  }

  int _bmiScore(double? bmi) {
    if (bmi == null || bmi <= 0) return 15;

    if (bmi >= 18.5 && bmi < 25) return 30;

    if ((bmi >= 16.5 && bmi < 18.5) || (bmi >= 25 && bmi < 30)) return 20;

    return 10;
  }

  WellnessMood _classify(int score) {
    if (score >= 75) return WellnessMood.excellent;
    if (score >= 45) return WellnessMood.good;
    return WellnessMood.needsAttention;
  }
}
