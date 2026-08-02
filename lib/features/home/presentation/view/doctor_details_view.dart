import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/core/widget/custom_scroll_widget.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_entity.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/doctor_details_widgets/contact_info_card.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/doctor_details_widgets/doctor_details_loading_skeleton.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/doctor_details_widgets/doctor_premium_avatar.dart';
import 'package:medicore_app/features/home/presentation/view_model/doctor_info_cubit/doctor_info_cubit.dart';

class DoctorDetailsView extends StatelessWidget {
  static const routeName = '/doctorDetails';
  final DoctorEntity doctor;
  final String assetImage;

  const DoctorDetailsView({
    super.key,
    required this.doctor,
    required this.assetImage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.select(
      (ThemeProvider provider) => provider.themeData,
    );
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => DoctorInfoCubit()..getDoctorInfo(doctor.doctorId),
      child: Scaffold(
        appBar: CustomAppBar(title: 'details'.tr(), isMainBar: false),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Builder(
          builder: (context) {
            return CustomScrollWidget(
              onRefresh: () {
                context.read<DoctorInfoCubit>().getDoctorInfo(doctor.doctorId);
                return Future.delayed(const Duration(seconds: 1));
              },
              child: BlocBuilder<DoctorInfoCubit, DoctorInfoState>(
                builder: (context, state) {
                  if (state is DoctorInfoLoading) {
                    return const DoctorDetailsLoadingSkeleton();
                  } else if (state is DoctorInfoFailure) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(state.error, style: TextStyles.notes),
                      ),
                    );
                  } else if (state is DoctorInfoSuccess) {
                    final info = state.doctorInfo;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 12),

                          DoctorPremiumAvatar(
                            assetImage: assetImage,
                            doctorId: doctor.doctorId.toString(),
                            isDark: isDark,
                          ),

                          const SizedBox(height: 20),
                          // Name
                          Text(
                            '${info.firstName} ${info.lastName}',
                            style: TextStyles.H1.copyWith(
                              color: isDark ? Colors.white : KBlack,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          // Speciality Label
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: KPrimaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${info.department}',
                              style: TextStyles.public.copyWith(
                                color: KPrimaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Rating
                          RatingBarIndicator(
                            rating: (info.rate ?? 3.5).toDouble(),
                            itemBuilder:
                                (context, _) => const Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                ),
                            itemCount: 5,
                            itemSize: 26,
                            direction: Axis.horizontal,
                          ),
                          const SizedBox(height: 32),
                          // Contact Information Title
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "contact_info".tr(),
                              style: TextStyles.H2.copyWith(
                                color: isDark ? Colors.white : KBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Phone Card
                          ContactInfoCard(
                            icon: Icons.phone_rounded,
                            title: "phone".tr(),
                            value: info.phone,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 12),
                          // Email Card
                          ContactInfoCard(
                            icon: Icons.email_rounded,
                            title: "email".tr(),
                            value: info.email,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 30),
                          Text(
                            "note".tr(),
                            style: TextStyles.notes.copyWith(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
