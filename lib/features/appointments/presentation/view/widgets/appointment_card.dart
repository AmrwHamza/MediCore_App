import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/image_card.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/info_row.dart';

class AppointmentCard extends StatelessWidget {
  final bool isChild;
  final bool isDone;
  final String imagePath;
  final String patientName;
  final String doctorName;
  final String status;
  final bool isMale;
  final DateTime date;
  final double? rating;

  const AppointmentCard({
    super.key,
    required this.isChild,
    required this.imagePath,
    required this.patientName,
    required this.status,
    required this.date,
    required this.doctorName,
    this.isMale = true,
    this.rating,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      color:
          isDone
              ? (isDark ? Colors.white10 : Colors.grey.shade200)
              : theme.cardColor,
      elevation: isDone ? 0 : 3,
      shadowColor: Colors.black.withValues(alpha: 0.04),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side:
            isDone
                ? BorderSide(
                  color: theme.dividerColor.withValues(alpha: 0.1),
                  width: 1.5,
                )
                : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCard(isChild: isChild, imagePath: imagePath, isMale: isMale),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(
                    icon: FontAwesomeIcons.person,
                    text: patientName,
                    iconColor: isDark ? Colors.white70 : KBlack,
                    textStyle: TextStyles.H2.copyWith(
                      color: isDark ? Colors.white : KBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  InfoRow(
                    icon: FontAwesomeIcons.clock,
                    text: status.tr(),
                    iconColor: _pickStatusColor(status),
                    textStyle: TextStyles.button.copyWith(
                      color: _pickStatusColor(status),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  InfoRow(
                    icon: FontAwesomeIcons.calendar,
                    text: DateFormat('dd/MM/yyyy - hh:mm a').format(date),
                    iconColor: KPrimaryColor,
                    textStyle: TextStyles.public.copyWith(
                      color: KPrimaryColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  InfoRow(
                    icon: FontAwesomeIcons.stethoscope,
                    text: doctorName,
                    iconColor: KDarkBlue,
                    textStyle: TextStyles.public.copyWith(
                      color: KDarkBlue,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: theme.dividerColor.withValues(alpha: 0.08),
                    height: 1,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.sticky_note_2_rounded,
                        color: Colors.grey.shade400,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _pickNote(status).tr(),
                          style: TextStyles.notes.copyWith(
                            fontSize: 11,
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (status == 'Done') ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (rating != null)
                          RatingBarIndicator(
                            rating: rating!,
                            itemBuilder:
                                (_, __) => const Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                ),
                            itemCount: 5,
                            itemSize: 18.0,
                          ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade600,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'rate'.tr(),
                              style: TextStyles.button.copyWith(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _pickStatusColor(String status) {
    switch (status) {
      case 'Waiting':
        return KPurple;
      case "In Progressing":
        return KOrange;
      case 'Done':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _pickNote(String status) {
    switch (status) {
      case 'Waiting':
        return 'waiting_note';
      case "In Progressing":
        return 'progress_note';
      case 'Done':
        return 'done_note';
      default:
        return '';
    }
  }
}
