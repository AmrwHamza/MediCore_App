import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';

class BloodTypeSelector extends StatelessWidget {
  final String? selectedType;
  final bool enabled;
  final ValueChanged<String> onChanged;

  final List<String> _bloodTypes = const [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  const BloodTypeSelector({
    super.key,
    required this.selectedType,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.6,
      child: AbsorbPointer(
        absorbing: !enabled,
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children:
              _bloodTypes.map((type) {
                final isSelected = selectedType == type;
                return GestureDetector(
                  onTap: () => onChanged(type),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? KPrimaryColor.withValues(alpha: 0.8)
                              : Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color:
                            isSelected
                                ? KPrimaryColor
                                : Colors.white.withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                      boxShadow:
                          isSelected
                              ? [
                                BoxShadow(
                                  color: Colors.redAccent.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 8,
                                ),
                              ]
                              : [],
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
