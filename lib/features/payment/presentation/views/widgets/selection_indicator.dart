import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';

class SelectionIndicator extends StatelessWidget {
  final bool isSelected;

  const SelectionIndicator({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? KPrimaryColor : const Color(0xff7C8283),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child:
            isSelected
                ? const CircleAvatar(radius: 6, backgroundColor: KPrimaryColor)
                : const SizedBox(width: 12, height: 12),
      ),
    );
  }
}
