import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/image_card.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/info_row.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AppointmentCard extends StatelessWidget {
  final bool isChild;
  final bool isDone;
  final String imagePath;
  final String patientName;
  final String doctorName;
  final String status;
  bool? isMale;
  final DateTime date;
  final double? rating;

  AppointmentCard({
    super.key,
    required this.isChild,
    required this.imagePath,
    required this.patientName,
    required this.status,
    required this.date,
    required this.doctorName,
    this.isMale,
    this.rating,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;
    return Card(
      color:
          isDone ? Colors.grey.withAlpha((0.4 * 255).round()) : theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side:
            isDone
                ? BorderSide(
                  color: Provider.of<ThemeProvider>(
                    context,
                  ).themeData.canvasColor.withAlpha((0.3 * 255).round()),
                  width: 2,
                )
                : BorderSide.none,
      ),

      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                ImageCard(
                  isChild: isChild,
                  imagePath: imagePath,
                  isMale: isMale,
                ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(
                    icon: Icons.person_outline_outlined,
                    text: patientName,
                    iconColor: theme.canvasColor,
                    textStyle: TextStyles.H2.copyWith(color: theme.canvasColor),
                  ),
                  InfoRow(
                    icon: Icons.watch_later_outlined,
                    text: status,
                    iconColor: _pickStatusColor(status),
                    textStyle: TextStyles.button.copyWith(
                      color: _pickStatusColor(status),
                    ),
                  ),

                  InfoRow(
                    icon: Icons.calendar_today_outlined,
                    text: DateFormat('dd/MM/yyyy - hh:mm a').format(date),
                    iconColor: KPrimaryColor,
                    textStyle: TextStyles.public.copyWith(color: KPrimaryColor),
                  ),

                  InfoRow(
                    icon: FontAwesomeIcons.stethoscope,
                    text: doctorName,
                    iconColor: KDarkBlue,
                    textStyle: TextStyles.public.copyWith(color: KDarkBlue),
                  ),

                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        FontAwesomeIcons.noteSticky,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _pickNote(status),
                          style: TextStyles.notes.copyWith(
                            fontSize: 10,
                            color: theme.canvasColor.withAlpha(
                              (0.7 * 255).round(),
                            ),
                          ),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  if (status == 'Done') const SizedBox(height: 8),
                  if (status == 'Done')
                    Row(
                      children: [
                        rating != null
                            ? RatingBarIndicator(
                              rating: rating!,
                              itemBuilder:
                                  (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                              itemCount: 5,
                              itemSize: 18.0,
                              direction: Axis.horizontal,
                            )
                            : const SizedBox.shrink(),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
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
        return const Color.fromARGB(255, 244, 67, 54);
      default:
        return KBlack;
    }
  }

  String _pickNote(String status) {
    switch (status) {
      case 'Waiting':
        return 'Please , be at the center a quarter of an hour before your appointment .';
      case "In Progressing":
        return 'Waiting for a doctor\'s review with the required documents';
      case 'Done':
        return 'Please Rate Your Experience';
      default:
        return '';
    }
  }
}
