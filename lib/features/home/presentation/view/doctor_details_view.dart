import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/core/widget/custom_scroll_widget.dart';
import 'package:medicore_app/core/widget/custom_shimer.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_entity.dart';
import 'package:medicore_app/features/home/presentation/view_model/doctor_info_cubit/doctor_info_cubit.dart';

class DoctorDetailsView extends StatelessWidget {
  static const routeName = '/doctorDetails';
  final DoctorEntity doctor;

  const DoctorDetailsView({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
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
                          // Doctor Profile Image with Premium Border
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: KPrimaryColor,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: KPrimaryColor.withValues(alpha: 0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  isDark ? KCardDark : KBackgroundLight,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(64),
                                child: CachedNetworkImage(
                                  imageUrl: '$base${info.imagePath}',
                                  fit: BoxFit.cover,
                                  width: 128,
                                  height: 128,
                                  errorWidget:
                                      (_, __, ___) => const FaIcon(
                                        FontAwesomeIcons.userDoctor,
                                        size: 40,
                                        color: KPrimaryColor,
                                      ),
                                ),
                              ),
                            ),
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
                              '${info.department }',
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

class ContactInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool isDark;

  const ContactInfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? KCardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.03),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color:
                isDark
                    ? Colors.black.withValues(alpha: 0.15)
                    : Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: KPrimaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: KPrimaryColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.notes.copyWith(
                      fontSize: 11,
                      color: KGrey,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyles.public.copyWith(
                      color:
                          isDark ? Colors.white.withValues(alpha: 0.9) : KBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorDetailsLoadingSkeleton extends StatelessWidget {
  const DoctorDetailsLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          SizedBox(height: 12),
          CustomShimer(height: 128, width: 128, radius: 64),
          SizedBox(height: 20),
          CustomShimer(height: 24, width: 200),
          SizedBox(height: 8),
          CustomShimer(height: 18, width: 120),
          SizedBox(height: 36),
          CustomShimer(height: 72, width: double.infinity),
          SizedBox(height: 12),
          CustomShimer(height: 72, width: double.infinity),
        ],
      ),
    );
  }
}
