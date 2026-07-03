import 'package:flutter/material.dart';
import 'package:medicore_app/core/widget/custom_shimer.dart';

class DepartmentDetailsLoadingList extends StatelessWidget {
  const DepartmentDetailsLoadingList({ this.isHorizontal = true});

  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder:
          (_, __) => const CustomShimer(
            height: 96,
            width: double.infinity,
            radius: 20,
          ),
    );
  }
}
