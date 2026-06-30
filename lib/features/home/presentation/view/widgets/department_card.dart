import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

class DepartmentCard extends StatefulWidget {
  final dynamic department;
  final bool? isSelected;
  final void Function()? onTap;

  const DepartmentCard({
    super.key,
    required this.department,
    this.onTap,
    this.isSelected,
  });

  @override
  State<DepartmentCard> createState() => _DepartmentCardState();
}

class _DepartmentCardState extends State<DepartmentCard> {
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
        scale: isCardSelected ? 1.05 : (_isHovered ? 1.02 : 1.0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: 105,
          decoration: BoxDecoration(
            gradient:
                isCardSelected
                    ? LinearGradient(
                      colors: [
                        KPrimaryColor,
                        KPrimaryColor.withValues(alpha: 0.85),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                    : LinearGradient(
                      colors:
                          isDark
                              ? [KCardDark, KCardDark.withValues(alpha: 0.7)]
                              : [
                                Colors.white,
                                Colors.grey.withValues(alpha: 0.05),
                              ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color:
                  isCardSelected
                      ? Colors.white.withValues(alpha: 0.3)
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : KPrimaryColor.withValues(alpha: 0.1)),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    isCardSelected
                        ? KPrimaryColor.withValues(alpha: 0.4)
                        : (isDark
                            ? Colors.black.withValues(alpha: 0.3)
                            : KPrimaryColor.withValues(alpha: 0.08)),
                blurRadius: isCardSelected ? 20 : 12,
                spreadRadius: isCardSelected ? 1 : 0,
                offset:
                    isCardSelected ? const Offset(0, 8) : const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(24),
                splashColor:
                    isCardSelected
                        ? Colors.white.withValues(alpha: 0.2)
                        : KPrimaryColor.withValues(alpha: 0.15),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient:
                              isCardSelected
                                  ? LinearGradient(
                                    colors: [
                                      Colors.white.withValues(alpha: 0.3),
                                      Colors.white.withValues(alpha: 0.1),
                                    ],
                                  )
                                  : LinearGradient(
                                    colors:
                                        isDark
                                            ? [KAppBarDark, KCardDark]
                                            : [
                                              KPrimaryColor.withValues(
                                                alpha: 0.05,
                                              ),
                                              KPrimaryColor.withValues(
                                                alpha: 0.15,
                                              ),
                                            ],
                                  ),
                          boxShadow: [
                            if (isCardSelected)
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child:
                              (widget.department.image != null &&
                                      widget.department.image.isNotEmpty)
                                  ? CachedNetworkImage(
                                    imageUrl: '$base${widget.department.image}',
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (context, url) => Center(
                                          child: SizedBox(
                                            width: 22,
                                            height: 22,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    isCardSelected
                                                        ? Colors.white
                                                        : KPrimaryColor,
                                                  ),
                                            ),
                                          ),
                                        ),
                                    errorWidget:
                                        (context, url, error) => Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.hospitalUser,
                                            color:
                                                isCardSelected
                                                    ? Colors.white
                                                    : KPrimaryColor,
                                            size: 22,
                                          ),
                                        ),
                                  )
                                  : Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.hospitalUser,
                                      color:
                                          isCardSelected
                                              ? Colors.white
                                              : KPrimaryColor,
                                      size: 22,
                                    ),
                                  ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.department.departmentName,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.public.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                          color:
                              isCardSelected
                                  ? Colors.white
                                  : (isDark
                                      ? Colors.white.withValues(alpha: 0.95)
                                      : KBlack),
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
