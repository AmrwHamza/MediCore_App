import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

class DoctorCardInDepartment extends StatefulWidget {
  final dynamic doctor;
  final void Function()? onTap;

  const DoctorCardInDepartment({super.key, required this.doctor, this.onTap});

  @override
  State<DoctorCardInDepartment> createState() => _DoctorCardInDepartmentState();
}

class _DoctorCardInDepartmentState extends State<DoctorCardInDepartment> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      // هنا نقوم بالتحريك الفيزيائي المتفاعل عند الضغط بسلاسة
      transform:
          _isPressed ? Matrix4.translationValues(4, -2, 0) : Matrix4.identity(),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              isDark
                  ? [KCardDark, KCardDark.withValues(alpha: 0.8)]
                  : [Colors.white, Colors.grey.withValues(alpha: 0.02)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color:
              isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : KPrimaryColor.withValues(alpha: 0.05),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color:
                isDark
                    ? Colors.black.withValues(alpha: 0.3)
                    : KPrimaryColor.withValues(alpha: 0.05),
            blurRadius: _isPressed ? 20 : 14,
            offset: _isPressed ? const Offset(0, 8) : const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) => setState(() => _isPressed = false),
            onTapCancel: () => setState(() => _isPressed = false),
            borderRadius: BorderRadius.circular(24),
            splashColor: KPrimaryColor.withValues(alpha: 0.08),
            highlightColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              KPrimaryColor.withValues(alpha: 0.4),
                              KPrimaryColor.withValues(alpha: 0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        padding: const EdgeInsets.all(3),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark ? KCardDark : Colors.white,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(36),
                            child:
                                (widget.doctor.user.imagePath != null &&
                                        widget.doctor.user.imagePath.isNotEmpty)
                                    ? CachedNetworkImage(
                                      imageUrl:
                                          '$base${widget.doctor.user.imagePath}',
                                      fit: BoxFit.cover,
                                      placeholder:
                                          (context, url) =>
                                              SpinKitSpinningLines(
                                                color: KPrimaryColor.withValues(
                                                  alpha: 0.6,
                                                ),
                                                size: 28,
                                              ),
                                      errorWidget:
                                          (context, url, error) => Center(
                                            child: FaIcon(
                                              FontAwesomeIcons.userDoctor,
                                              color: KPrimaryColor.withValues(
                                                alpha: 0.6,
                                              ),
                                              size: 24,
                                            ),
                                          ),
                                    )
                                    : Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.userDoctor,
                                        color: KPrimaryColor.withValues(
                                          alpha: 0.6,
                                        ),
                                        size: 24,
                                      ),
                                    ),
                          ),
                        ),
                      ),
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: KPrimaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark ? KCardDark : Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 10,
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
                        Text(
                          widget.doctor.user.firstName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.public.copyWith(
                            color: isDark ? Colors.white : KBlack,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.doctor.department != null
                              ? widget.doctor.department!.name
                              : '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.notes.copyWith(
                            color:
                                isDark
                                    ? Colors.white.withValues(alpha: 0.6)
                                    : KGrey,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RatingBarIndicator(
                          rating: widget.doctor.rate ?? 0.0,
                          itemBuilder:
                              (context, _) => const Icon(
                                Icons.star_rounded,
                                color: Color(0xFFFFC107),
                              ),
                          itemCount: 5,
                          itemSize: 18.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _isPressed
                              ? KPrimaryColor
                              : (isDark
                                  ? Colors.white.withValues(alpha: 0.04)
                                  : KPrimaryColor.withValues(alpha: 0.05)),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color:
                            _isPressed
                                ? Colors.white
                                : (isDark
                                    ? Colors.white.withValues(alpha: 0.4)
                                    : KPrimaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
