import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';

class ProviderLogoContainer extends StatelessWidget {
  final bool isDark;
  final bool isSelected;
  final String assetPath;

  const ProviderLogoContainer({
    super.key,
    required this.isDark,
    required this.isSelected,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color:
            isSelected
                ? (isDark ? KBackgroundDark : Colors.white)
                : (isDark ? KBackgroundDark : const Color(0xffE7F9FE)),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? KPrimaryColor.withAlpha(80) : Colors.transparent,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Image.asset(assetPath, fit: BoxFit.contain),
    );
  }
}
