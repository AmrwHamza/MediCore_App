import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/widget/custom_scroll_widget.dart';
import 'package:medicore_app/features/notification/presentation/view/widgets/notification_card.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollWidget(
      color: KDarkBlue,
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return const NotificationCard(
            title: 'Dear Customer',
            subTitle: 'Don\'t forget your appointment tomorrow at 10:30',
          );
        },
      ),
    );
  }
}
