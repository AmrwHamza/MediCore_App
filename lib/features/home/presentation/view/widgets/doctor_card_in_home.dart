import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

class DoctorCardInHome extends StatefulWidget {
  final dynamic doctor;
  final bool? isSelected;
  final void Function()? onTap;

  const DoctorCardInHome({
    super.key,
    required this.doctor,
    this.onTap,
    this.isSelected,
  });

  @override
  State<DoctorCardInHome> createState() => _DoctorCardInHomeState();
}

class _DoctorCardInHomeState extends State<DoctorCardInHome> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;
    final isCardSelected = widget.isSelected ?? false;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: isCardSelected ? 1.04 : (_isHovered ? 1.02 : 1.0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: 155,
          decoration: BoxDecoration(
            gradient:
                isCardSelected
                    ? const LinearGradient(
                      colors: [KPrimaryColor, KDarkBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                    : LinearGradient(
                      colors:
                          isDark
                              ? [KCardDark, KCardDark.withValues(alpha: 0.75)]
                              : [
                                Colors.white,
                                Colors.white.withValues(alpha: 0.9),
                              ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color:
                  isCardSelected
                      ? Colors.white.withValues(alpha: 0.25)
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.06)
                          : Colors.black.withValues(alpha: 0.04)),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    isCardSelected
                        ? KDarkBlue.withValues(alpha: 0.35)
                        : (isDark
                            ? Colors.black.withValues(alpha: 0.3)
                            : KPrimaryColor.withValues(alpha: 0.06)),
                blurRadius: isCardSelected ? 24 : 16,
                spreadRadius: isCardSelected ? 2 : 0,
                offset:
                    isCardSelected ? const Offset(0, 10) : const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(28),
                splashColor:
                    isCardSelected
                        ? Colors.white.withValues(alpha: 0.15)
                        : KPrimaryColor.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 74,
                            height: 74,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: SweepGradient(
                                colors:
                                    isCardSelected
                                        ? [
                                          Colors.white,
                                          Colors.white.withValues(alpha: 0.4),
                                          Colors.white,
                                        ]
                                        : [
                                          KPrimaryColor,
                                          KPrimaryColor.withValues(alpha: 0.2),
                                          KPrimaryColor,
                                        ],
                              ),
                            ),
                            padding: const EdgeInsets.all(2.5),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDark ? KCardDark : Colors.white,
                              ),
                              padding: const EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(37),
                                child:
                                    (widget.doctor.user.imagePath != null &&
                                            widget
                                                .doctor
                                                .user
                                                .imagePath
                                                .isNotEmpty)
                                        ? CachedNetworkImage(
                                          imageUrl:
                                              '$base${widget.doctor.user.imagePath}',
                                          fit: BoxFit.cover,
                                          placeholder:
                                              (context, url) => const Center(
                                                child: SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                          Color
                                                        >(KPrimaryColor),
                                                  ),
                                                ),
                                              ),
                                          errorWidget:
                                              (context, url, error) => Center(
                                                child: FaIcon(
                                                  FontAwesomeIcons.userDoctor,
                                                  color:
                                                      isCardSelected
                                                          ? KPrimaryColor
                                                          : KGrey,
                                                  size: 26,
                                                ),
                                              ),
                                        )
                                        : Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.userDoctor,
                                            color:
                                                isCardSelected
                                                    ? KPrimaryColor
                                                    : KGrey,
                                            size: 26,
                                          ),
                                        ),
                              ),
                            ),
                          ),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2ECC71),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 4,
                                ),
                              ],
                              border: Border.all(
                                color:
                                    isCardSelected
                                        ? KDarkBlue
                                        : (isDark ? KCardDark : Colors.white),
                                width: 2.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'dr'.tr() + ' ${widget.doctor.user.firstName}',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.public.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.2,
                          color:
                              isCardSelected
                                  ? Colors.white
                                  : (isDark ? Colors.white : KBlack),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.doctor.department != null
                            ? widget.doctor.department!.name
                            : '',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.notes.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color:
                              isCardSelected
                                  ? Colors.white.withValues(alpha: 0.75)
                                  : KGrey.withValues(alpha: 0.9),
                        ),
                      ),
                      const SizedBox(height: 10),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isCardSelected
                                  ? Colors.white.withValues(alpha: 0.12)
                                  : (isDark
                                      ? Colors.white.withValues(alpha: 0.04)
                                      : KPrimaryColor.withValues(alpha: 0.06)),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color:
                                isCardSelected
                                    ? Colors.white.withValues(alpha: 0.1)
                                    : Colors.transparent,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFFFC107),
                              size: 15,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              (widget.doctor.rate ?? 0.0).toStringAsFixed(1),
                              style: TextStyles.public.copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color:
                                    isCardSelected
                                        ? Colors.white
                                        : (isDark
                                            ? Colors.white.withValues(
                                              alpha: 0.9,
                                            )
                                            : KBlack),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
