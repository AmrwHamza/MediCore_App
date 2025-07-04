
import 'package:flutter/material.dart';
import 'package:medicore_app/core/widget/custom_shimer.dart';

class LoadingShimerList extends StatelessWidget {
  const LoadingShimerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder:
          (_, __) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: CustomShimer(),
          ),
    );
  }
}
