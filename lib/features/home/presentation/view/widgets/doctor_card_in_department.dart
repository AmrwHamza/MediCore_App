import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class DoctorCardInDepartment extends StatelessWidget {
  final String name;
  final String department;
  final double rating;
  final String? imageUrl;
  final void Function()? onTap;

  const DoctorCardInDepartment({
    Key? key,
    required this.name,
    required this.department,
    required this.rating,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        highlightColor: theme.shadowColor,
        onTap: onTap,
        child: Row(
          children: [
            (imageUrl != null && imageUrl!.isNotEmpty)
                ? CachedNetworkImage(
                  placeholder:
                      (context, url) => SpinKitSpinningLines(
                        color: KPrimaryColor.withAlpha((0.5 * 255).round()),
                      ),
                  errorWidget:
                      (context, url, error) => const Icon(Icons.broken_image),
                  color: KPrimaryColor,
                  imageUrl: '$base$imageUrl',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                )
                : const CircleAvatar(
                  backgroundColor: KPrimaryColor,
                  radius: 25,
                  child: Icon(
                    FontAwesomeIcons.userDoctor,
                    color: Colors.white70,
                  ),
                ),

            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyles.public.copyWith(
                      color:
                          Provider.of<ThemeProvider>(
                            context,
                          ).themeData.canvasColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    department,
                    style: TextStyles.public.copyWith(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RatingBarIndicator(
                    rating: rating,
                    itemBuilder:
                        (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
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
