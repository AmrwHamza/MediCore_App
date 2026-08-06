import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';

class GenderSelector extends StatelessWidget {
  final String? selectedGender;
  final bool enabled;
  final ValueChanged<String> onChanged;

  const GenderSelector({
    super.key,
    required this.selectedGender,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Opacity(
      opacity: enabled ? 1.0 : 0.6,
      child: AbsorbPointer(
        absorbing: !enabled,
        child: Row(
          children: [
            Expanded(
              child: _buildGenderCard(
                'Male',
                Icons.male,
                KPrimaryColor,
                isDark,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildGenderCard(
                'Female',
                Icons.female,
                Colors.pink,
                isDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderCard(
    String gender,
    IconData icon,
    Color activeColor,
    bool isDark,
  ) {
    final isSelected = selectedGender?.toLowerCase() == gender.toLowerCase();
    final unselectedColor = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : KDisabledLight.withValues(alpha: 0.35);
    final unselectedBorder = isDark
        ? Colors.white.withValues(alpha: 0.15)
        : KBorderLight;
    final unselectedFg = isDark ? Colors.white60 : KGrey;

    return GestureDetector(
      onTap: () => onChanged(gender),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withValues(alpha: isDark ? 0.35 : 0.15)
              : unselectedColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? activeColor : unselectedBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? activeColor : unselectedFg,
            ),
            const SizedBox(height: 8),
            Text(
              gender.tr(),
              style: TextStyle(
                color: isSelected
                    ? (isDark ? Colors.white : KPrimaryDark)
                    : unselectedFg,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}