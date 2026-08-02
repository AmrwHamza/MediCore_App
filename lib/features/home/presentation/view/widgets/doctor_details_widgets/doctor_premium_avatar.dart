import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/utils/app_images.dart';

class DoctorPremiumAvatar extends StatelessWidget {
  final String doctorId;
  final bool isDark;
  final double size;
  final String assetImage;

  const DoctorPremiumAvatar({
    super.key,
    required this.doctorId,
    required this.isDark,
    this.size = 134,
    required this.assetImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [KPrimaryColor, KDarkBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: KPrimaryColor.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? KCardDark : Colors.white,
        ),
        padding: const EdgeInsets.all(1.5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
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
                    width: size * 0.67,
                    height: size * 0.67,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              Positioned.fill(
                child: Image.asset(
                  assetImage,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (context, error, stackTrace) {
                     return Image.asset(
                      Assets.doctorsImages[0],
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
