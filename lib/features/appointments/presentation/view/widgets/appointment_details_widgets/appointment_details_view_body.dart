import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/appointment_card_info.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/appointment_doctor_rating.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/doctor_details_section.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/upload_section.dart';

import '../../../../data/models/appointment_types.dart';
import '../../../../domain/entities/privew_entity.dart';
import '../image_card.dart';
import 'medication_item.dart';

class AppointmentDetailsViewBody extends StatelessWidget {
  const AppointmentDetailsViewBody({super.key, required this.privewEntity});

  final PrivewEntity privewEntity;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;
    final mutedTextColor = isDark
        ? Colors.white.withValues(alpha: 0.6)
        : Colors.grey[600];

    final parsedDate = DateTime.tryParse(privewEntity.date) ?? DateTime.now();
    final localeCode = context.locale.languageCode;

    return Stack(
      children: [
        Positioned(
          top: -120.h,
          right: -100.w,
          child: Container(
            width: 320.r,
            height: 320.r,
            decoration: BoxDecoration(
              color: KPrimaryColor.withValues(alpha: isDark ? 0.05 : 0.04),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -160.h,
          left: -120.w,
          child: Container(
            width: 300.r,
            height: 300.r,
            decoration: BoxDecoration(
              color: KPrimaryColor.withValues(alpha: isDark ? 0.04 : 0.03),
              shape: BoxShape.circle,
            ),
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AppointmentSummaryCard(
                privewEntity: privewEntity,
                isDark: isDark,
                parsedDate: parsedDate,
                localeCode: localeCode,
                mutedTextColor: mutedTextColor,
              ),

              SizedBox(height: 24.h),

              DoctorDetailsSection(privewEntity: privewEntity),

              SizedBox(height: 24.h),

              _DiagnosisSection(privewEntity: privewEntity, isDark: isDark),

              if (isIncompleteDiagnosis(privewEntity)) ...[
                SizedBox(height: 24.h),
                UploadSection(privewEntity: privewEntity),
              ],

              SizedBox(height: 24.h),
              AppointmentCardInfo(
                title: 'appointment_details_prescription_and_meds'.tr(),
                child: privewEntity.medicine.isEmpty
                    ? Text(
                        'appointment_details_no_meds_recorded'.tr(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: mutedTextColor,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: privewEntity.medicine
                            .split(',')
                            .map(
                              (med) => MedicationItem(
                                medicationName: med.trim(),
                              ),
                            )
                            .toList(),
                      ),
              ),

              SizedBox(height: 24.h),
              AppointmentDoctorRating(privewEntity: privewEntity),

              SizedBox(height: 28.h),
              Container(
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.04)
                      : KPrimaryColor.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: pickStatusColor(privewEntity.status).withValues(
                          alpha: 0.1,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.info_outline_rounded,
                        color: pickStatusColor(privewEntity.status),
                        size: 16.r,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        pickNote(
                          fromStringToAppointmentTypes(privewEntity.status),
                        ).tr(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: mutedTextColor,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AppointmentSummaryCard extends StatelessWidget {
  final PrivewEntity privewEntity;
  final bool isDark;
  final DateTime parsedDate;
  final String localeCode;
  final Color? mutedTextColor;

  const _AppointmentSummaryCard({
    required this.privewEntity,
    required this.isDark,
    required this.parsedDate,
    required this.localeCode,
    this.mutedTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: isDark ? KCardDark : Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.05),
            blurRadius: 24.r,
            offset: const Offset(0, 12),
          ),
        ],
        border: Border.all(
          color: isDark
              ? KBorderDark.withValues(alpha: 0.3)
              : KPrimaryColor.withValues(alpha: 0.1),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'appointment_summary'.tr().toUpperCase(),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: KPrimaryColor,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              _StatusBadge(status: privewEntity.status),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy', localeCode).format(parsedDate),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : KDarkBlue,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 14.r,
                          color: KPrimaryColor,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          DateFormat('hh:mm a', localeCode).format(parsedDate),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: mutedTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            width: double.infinity,
            height: 1.h,
            color: isDark
                ? Colors.white.withValues(alpha: 0.06)
                : KPrimaryColor.withValues(alpha: 0.06),
          ),
          SizedBox(height: 18.h),
          Row(
            children: [
              ImageCard(
                isChild: privewEntity.isChild,
                imagePath: privewEntity.imgPath,
                isMale: privewEntity.gender == 'male',
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      privewEntity.patientName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : KDarkBlue,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'patient'.tr(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: mutedTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Row(
            children: [
              Expanded(
                child: _SummaryItem(
                  icon: Icons.fingerprint_rounded,
                  label: 'appointment_details_preview_number'.tr(),
                  value: '#${privewEntity.id}',
                  isDark: isDark,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _SummaryItem(
                  icon: Icons.badge_outlined,
                  label: 'appointment_details_international_patient_id'.tr(),
                  value: '${privewEntity.patientId}',
                  isDark: isDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = pickStatusColor(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.25), width: 1.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.r,
            height: 6.r,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 6.w),
          Text(
            status.toUpperCase(),
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: color,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isDark;

  const _SummaryItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : KPrimaryColor.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16.r, color: KPrimaryColor),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: isDark ? Colors.white38 : Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : KDarkBlue,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DiagnosisSection extends StatelessWidget {
  final PrivewEntity privewEntity;
  final bool isDark;

  const _DiagnosisSection({required this.privewEntity, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final bool isComplete = privewEntity.diagnoseisType == 1;

    return AppointmentCardInfo(
      title: 'diagnosis'.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isComplete
                  ? KSuccess.withValues(alpha: 0.06)
                  : KOrange.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isComplete
                    ? KSuccess.withValues(alpha: 0.15)
                    : KOrange.withValues(alpha: 0.15),
                width: 1.w,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: isComplete
                        ? KSuccess.withValues(alpha: 0.15)
                        : KOrange.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isComplete
                        ? Icons.check_circle_outline_rounded
                        : Icons.pending_outlined,
                    color: isComplete ? KSuccess : KOrange,
                    size: 20.r,
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isComplete
                            ? 'diagnosis_complete'.tr()
                            : 'diagnosis_incomplete'.tr(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: isComplete ? KSuccess : KOrange,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        isComplete
                            ? 'diagnosis_complete_hint'.tr()
                            : 'diagnosis_incomplete_hint'.tr(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: isDark ? Colors.white60 : Colors.black54,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (privewEntity.diagnoseis.isNotEmpty) ...[
            SizedBox(height: 18.h),
            Text(
              privewEntity.diagnoseis,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : KDarkBlue,
                height: 1.5,
              ),
            ),
          ],
          if (privewEntity.notes.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.04)
                    : KPrimaryColor.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isDark
                      ? Colors.white10
                      : KPrimaryColor.withValues(alpha: 0.08),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.notes_rounded, size: 16.r, color: KPrimaryColor),
                      SizedBox(width: 8.w),
                      Text(
                        'doctor_notes'.tr(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: KPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    privewEntity.notes,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white70 : Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
