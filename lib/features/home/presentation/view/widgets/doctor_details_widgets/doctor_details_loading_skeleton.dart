import 'package:flutter/material.dart';
import 'package:medicore_app/core/widget/custom_shimer.dart';

class DoctorDetailsLoadingSkeleton extends StatelessWidget {
  const DoctorDetailsLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          SizedBox(height: 12),
          CustomShimer(height: 128, width: 128, radius: 64),
          SizedBox(height: 20),
          CustomShimer(height: 24, width: 200),
          SizedBox(height: 8),
          CustomShimer(height: 18, width: 120),
          SizedBox(height: 36),
          CustomShimer(height: 72, width: double.infinity),
          SizedBox(height: 12),
          CustomShimer(height: 72, width: double.infinity),
        ],
      ),
    );
  }
}
