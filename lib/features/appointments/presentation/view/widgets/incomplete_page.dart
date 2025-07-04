import 'package:flutter/material.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/core/widget/custom_scroll_widget.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_card.dart';

class IncompletePage extends StatelessWidget {
  const IncompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollWidget(
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            child: AppointmentCard(
              isDone: false,
              isChild: false,
              imagePath: Assets.imagesMe,
              patientName: 'Tarek Alasfour',
              status: 'Done',
              date: DateTime(2000),
              doctorName: "Dr.Tarek Alasfour",
              rating: 4,
              isMale: true,
            ),
          );
        },
      ),
    );
  }
}
