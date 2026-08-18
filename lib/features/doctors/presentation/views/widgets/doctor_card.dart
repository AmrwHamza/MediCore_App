import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_entity.dart';

class DoctorCard extends StatelessWidget {
  final DoctorEntity doctor;
  final VoidCallback? onTap;

  const DoctorCard({super.key, required this.doctor, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    final doctorIdInt = int.tryParse(doctor.doctorId.toString()) ?? 0;
    final String finalImage =
        Assets.doctorsImages[doctorIdInt % Assets.doctorsImages.length];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.shadowColor.withAlpha(15), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: theme.splashColor.withAlpha(20),
          highlightColor: theme.shadowColor.withAlpha(10),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: const LinearGradient(
                          colors: [KPrimaryColor, KDarkBlue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [KCyan, KPrimaryLight],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            Center(
                              child: Opacity(
                                opacity: 0.5,
                                child: Image.asset(
                                  'assets/images/Logo_without_background.png',
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Image.asset(
                                finalImage,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                errorBuilder:
                                    (context, error, stackTrace) => Icon(
                                      Icons.person_rounded,
                                      size: 40,
                                      color: isDark ? KCyan : KPrimaryColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (doctor.rate != null)
                      Positioned(
                        bottom: -6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isDark ? KCardDark : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(20),
                                blurRadius: 4,
                              ),
                            ],
                            border: Border.all(
                              color: KOrange.withAlpha(60),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: KOrange,
                                size: 12,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                doctor.rate!.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: KOrange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${doctor.user.firstName} ${doctor.user.lastName}',
                              style: TextStyles.H2.copyWith(
                                color: theme.canvasColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Directionality.of(context) == TextDirection.rtl
                                ? Icons.arrow_back_ios_new_rounded
                                : Icons.arrow_forward_ios_rounded,
                            color:
                                isDark ? Colors.white30 : KGrey.withAlpha(120),
                            size: 14,
                          ),
                        ],
                      ),
                      if (doctor.department != null) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isDark
                                    ? KCyan.withAlpha(25)
                                    : KPrimaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            doctor.department!.name,
                            style: TextStyle(
                              color: isDark ? KCyan : KPrimaryColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        doctor.bio,
                        style: TextStyle(
                          color: isDark ? Colors.white60 : KGrey,
                          fontSize: 12,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
