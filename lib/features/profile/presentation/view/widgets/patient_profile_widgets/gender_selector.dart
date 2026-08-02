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
    return Opacity(
      opacity: enabled ? 1.0 : 0.6,
      child: AbsorbPointer(
        absorbing: !enabled,
        child: Row(
          children: [
            Expanded(
              child: _buildGenderCard('Male', Icons.male, KPrimaryColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildGenderCard('Female', Icons.female, Colors.pink),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderCard(String gender, IconData icon, Color activeColor) {
    final isSelected = selectedGender?.toLowerCase() == gender.toLowerCase();

    return GestureDetector(
      onTap: () => onChanged(gender),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? activeColor.withValues(alpha: 0.25)
                  : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isSelected ? activeColor : Colors.white.withValues(alpha: 0.2),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? activeColor : Colors.white60,
            ),
            const SizedBox(height: 8),
            Text(
              gender.tr(),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
