import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

class DoctorCardInHome extends StatelessWidget {
  final String name;
  final String department;
  final double rating;
  final String? imageUrl;
  final bool? isSelected;
  final void Function()? onTap;

  const DoctorCardInHome({
    super.key,
    required this.name,
    required this.department,
    required this.rating,
    this.imageUrl,
    this.onTap,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color:
              (isSelected != null)
                  ? isSelected!
                      ? KPrimaryColor
                      : theme.cardColor
                  : theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color:
                  (isSelected != null)
                      ? isSelected!
                          ? KDarkBlue.withAlpha((0.2 * 255).round())
                          : theme.shadowColor
                      : theme.shadowColor,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            (imageUrl != null && imageUrl!.isNotEmpty)
                ? CachedNetworkImage(
                  placeholder:
                      (context, url) => const CircularProgressIndicator(),
                  errorWidget:
                      (context, url, error) => const Icon(Icons.broken_image),
                  color: KPrimaryColor,
                  imageUrl: '$base$imageUrl',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                )
                : CircleAvatar(
                  backgroundColor:
                      (isSelected == true) ? Colors.white70 : KPrimaryColor,
                  radius: 25,
                  child: Icon(
                    FontAwesomeIcons.userDoctor,
                    color:
                        (isSelected == true) ? KPrimaryColor : Colors.white70,
                  ),
                ),
            const SizedBox(height: 10),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyles.public.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color:
                    (isSelected == true) ? Colors.white70 : theme.canvasColor,
              ),
            ),
            Text(
              department,
              textAlign: TextAlign.center,
              style: TextStyles.public.copyWith(
                fontSize: 12,
                color: theme.hintColor,
              ),
            ),
            RatingBarIndicator(
              rating: rating,
              itemBuilder:
                  (context, _) => const Icon(Icons.star, color: Colors.amber),
              itemCount: 5,
              itemSize: 16.0,
              direction: Axis.horizontal,
            ),
          ],
        ),
      ),
    );
  }
}
