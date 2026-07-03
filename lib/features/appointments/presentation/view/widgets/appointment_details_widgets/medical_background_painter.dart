import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';

class MedicalBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = KPrimaryColor.withValues(alpha: 0.03)
          ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.1, size.height * 0.15),
      80.r,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.4),
      120.r,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.75),
      100.r,
      paint,
    );

    final pathPaint =
        Paint()
          ..color = KPrimaryColor.withValues(alpha: 0.02)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.w;

    final path =
        Path()
          ..moveTo(0, size.height * 0.3)
          ..quadraticBezierTo(
            size.width * 0.3,
            size.height * 0.25,
            size.width * 0.5,
            size.height * 0.35,
          )
          ..quadraticBezierTo(
            size.width * 0.8,
            size.height * 0.45,
            size.width,
            size.height * 0.4,
          );

    canvas.drawPath(path, pathPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
