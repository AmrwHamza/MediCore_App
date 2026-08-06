import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/features/appointments/domain/entities/privew_entity.dart';
import 'package:medicore_app/features/family/presentation/view/widgets/child_details_widgets/timeline_node_card.dart';

class HealthTimelineStepper extends StatelessWidget {
  final List<PrivewEntity> previews;

  const HealthTimelineStepper({super.key, required this.previews});

  @override
  Widget build(BuildContext context) {
    final sorted = List<PrivewEntity>.from(previews);
    sorted.sort((a, b) => b.date.compareTo(a.date));

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      itemCount: sorted.length,
      itemBuilder: (context, index) {
        final preview = sorted[index];
        final isFirst = index == 0;
        final isLast = index == sorted.length - 1;

        return TimelineNodeCard(
          preview: preview,
          isFirst: isFirst,
          isLast: isLast,
        );
      },
    );
  }
}