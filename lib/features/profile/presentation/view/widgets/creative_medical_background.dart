import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';

class CreativeMedicalBackground extends StatelessWidget {
  final Widget child;
  final ThemeData theme;

  const CreativeMedicalBackground({
    super.key,
    required this.child,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color:
              theme.scaffoldBackgroundColor == Colors.white
                  ? const Color(0xFFF4F7FA)
                  : const Color(0xFF0A0E1A),
        ),
        Positioned(
          top: -100,
          right: -50,
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.primaryColor.withValues(alpha: 0.25),
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: -80,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: KDarkBlue.withValues(alpha: 0.3),
            ),
          ),
        ),
        Positioned(
          top: 300,
          right: 80,
          child: Container(
            width: 180,
            height: 180,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.cyanAccent,
            ),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: _MedicalMeshPainter(
              color: theme.primaryColor.withValues(alpha: 0.06),
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 90.0, sigmaY: 90.0),
            child: Container(color: Colors.transparent),
          ),
        ),
        SafeArea(child: child),
      ],
    );
  }
}

class _MedicalMeshPainter extends CustomPainter {
  final Color color;
  _MedicalMeshPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

    final double spacing = 40.0;
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
