import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/appointment_card_info.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/appointment_doctor_rating.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/appointment_row_info.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/doctor_details_section.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/upload_section.dart';

import '../../../../data/models/appointment_types.dart';
import '../../../../domain/entities/privew_entity.dart';
import '../image_card.dart';
import 'medical_background_painter.dart';
import 'medication_item.dart';
import 'upload_widgets/completed_analysis_card.dart';

class AppointmentDetailsViewBody extends StatelessWidget {
  const AppointmentDetailsViewBody({super.key, required this.privewEntity});

  final PrivewEntity privewEntity;

  bool get _isCompleted {
    final status = privewEntity.status.toLowerCase();
    return status == 'complete' || status == 'completed';
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;
    final primaryTextColor = isDark ? Colors.white : Colors.black87;
    final mutedTextColor = isDark
        ? Colors.white.withValues(alpha: 0.6)
        : Colors.grey[600];

    final parsedDate = DateTime.tryParse(privewEntity.date) ?? DateTime.now();
    final localeCode = context.locale.languageCode;
    final formattedDate = DateFormat(
      'yyyy/MM/dd hh:mm a',
      localeCode,
    ).format(parsedDate);

    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(painter: MedicalBackgroundPainter()),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppointmentCardInfo(
                title: 'appointment_details_patient_info'.tr(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ImageCard(
                          isChild: privewEntity.isChild,
                          imagePath: privewEntity.imgPath,
                          isMale: privewEntity.gender == 'male',
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                privewEntity.patientName,
                                style: TextStyles.public.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: primaryTextColor,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              if (privewEntity.diagnoseisType != 0)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: KOrange.withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    privewEntity.diagnoseisType.toString(),
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                      color: KOrange,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Divider(
                      color: isDark
                          ? KBorderDark.withValues(alpha: 0.5)
                          : Colors.grey.withValues(alpha: 0.08),
                      height: 1.h,
                    ),
                    SizedBox(height: 12.h),
                    AppointmentRowInfo(
                      icon: Icons.fingerprint_rounded,
                      label: 'appointment_details_preview_number'.tr(),
                      value: '#${privewEntity.id}',
                    ),
                    SizedBox(height: 10.h),
                    AppointmentRowInfo(
                      icon: Icons.badge_outlined,
                      label:
                          'appointment_details_international_patient_id'.tr(),
                      value: '${privewEntity.patientId}',
                    ),
                    SizedBox(height: 10.h),
                    AppointmentRowInfo(
                      icon: Icons.today_rounded,
                      label: 'appointment_details_preview_date'.tr(),
                      value: formattedDate,
                    ),
                  ],
                ),
              ),
              if (canUploadMedicalAnalysis(privewEntity)) ...[
                SizedBox(height: 16.h),
                UploadSection(privewEntity: privewEntity),
              ],
              if (_isCompleted &&
                  privewEntity.analysisFile.trim().isNotEmpty) ...[
                SizedBox(height: 16.h),
                CompletedAnalysisCard(
                  fileName: privewEntity.analysisFile,
                  fileUrl: privewEntity.analysisFile,
                ),
              ],
              if (privewEntity.diagnoseis.isNotEmpty) ...[
                SizedBox(height: 16.h),
                AppointmentCardInfo(
                  title: 'appointment_details_medical_diagnosis'.tr(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        privewEntity.diagnoseis,
                        style: TextStyles.public.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: primaryTextColor,
                        ),
                      ),
                      if (privewEntity.notes.isNotEmpty) ...[
                        SizedBox(height: 16.h),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            gradient: LinearGradient(
                              colors: [
                                KPrimaryColor.withValues(alpha: 0.06),
                                KPrimaryColor.withValues(alpha: 0.01),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(
                              color: KPrimaryColor.withValues(alpha: 0.12),
                              width: 1.w,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: KPrimaryColor.withValues(alpha: 0.02),
                                blurRadius: 10.r,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: -20.w,
                                  top: -20.h,
                                  child: CircleAvatar(
                                    radius: 40.r,
                                    backgroundColor: KPrimaryColor.withValues(
                                      alpha: 0.04,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 12.w,
                                  bottom: 12.h,
                                  child: Icon(
                                    Icons.format_quote_rounded,
                                    size: 48.r,
                                    color: KPrimaryColor.withValues(
                                      alpha: 0.05,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(16.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6.r),
                                            decoration: BoxDecoration(
                                              color: KPrimaryColor.withValues(
                                                alpha: 0.1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            child: Icon(
                                              Icons.gavel_rounded,
                                              size: 16.r,
                                              color: KPrimaryColor,
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Text(
                                            'appointment_details_doctor_notes'
                                                .tr(),
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                              color: isDark
                                                  ? Colors.white
                                                  : KDarkBlue,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 4.w,
                                        ),
                                        child: Text(
                                          privewEntity.notes,
                                          style: TextStyles.notes.copyWith(
                                            fontSize: 13.sp,
                                            color: primaryTextColor,
                                            height: 1.5,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
              SizedBox(height: 16.h),
              AppointmentCardInfo(
                title: 'appointment_details_prescription_and_meds'.tr(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (privewEntity.medicine.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Text(
                          'appointment_details_no_meds_recorded'.tr(),
                          style: TextStyle(fontSize: 13.sp, color: mutedTextColor),
                        ),
                      )
                    else
                      ...privewEntity.medicine
                          .split(',')
                          .map(
                            (med) => MedicationItem(medicationName: med.trim()),
                          ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              DoctorDetailsSection(privewEntity: privewEntity),
              SizedBox(height: 16.h),
              AppointmentDoctorRating(privewEntity: privewEntity),
              SizedBox(height: 24.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: pickStatusColor(
                        privewEntity.status,
                      ).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.info_outline_rounded,
                      color: pickStatusColor(privewEntity.status),
                      size: 18.r,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        pickNote(
                          fromStringToAppointmentTypes(privewEntity.status),
                        ).tr(),
                        style: TextStyles.notes.copyWith(
                          fontSize: 14.sp,
                          color: mutedTextColor,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                        maxLines: null,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
