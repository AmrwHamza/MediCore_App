import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/utils/app_images.dart';

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

    final id = int.tryParse(widget.department.id.toString()) ?? 1;
    final imageIndex = (id - 1) % 15;
    final localAssetImage = Assets.departmentsImages[imageIndex];

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
            child: Stack(
              children: [
                if (isCardSelected)
                  Positioned(
                    top: -15,
                    right: -15,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                    ),
                  ),
                Positioned.fill(
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
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      isCardSelected
                                          ? Colors.white.withValues(alpha: 0.4)
                                          : KPrimaryColor.withValues(
                                            alpha: 0.2,
                                          ),
                                  width: 1.5,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Image.asset(
                                        localAssetImage,
                                        fit: BoxFit.cover,
                                        color:
                                            isCardSelected
                                                ? const Color(
                                                  0xFF0F2B48,
                                                ).withValues(alpha: 0.2)
                                                : const Color(
                                                  0xFF0F2B48,
                                                ).withValues(alpha: 0.4),
                                        colorBlendMode: BlendMode.multiply,
                                      ),
                                    ),
                                    Center(
                                      child: Opacity(
                                        opacity: isCardSelected ? 0.4 : 0.3,
                                        child: Image.asset(
                                          Assets.imagesLogoWithoutBackground,
                                          width: 32,
                                          height: 32,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
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
                                            ? Colors.white.withValues(
                                              alpha: 0.95,
                                            )
                                            : KBlack),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
