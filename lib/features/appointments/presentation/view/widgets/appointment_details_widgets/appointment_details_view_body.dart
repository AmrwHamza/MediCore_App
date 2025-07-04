import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/utils/app_images.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/appointment_card_info.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/appointment_details_widgets/appointment_row_info.dart';

class AppointmentDetailsViewBody extends StatelessWidget {
  const AppointmentDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Patient Information Card
          AppointmentCardInfo(
            title: 'Patient information',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '',
                  // appointment.patientName,
                  style: TextStyles.public.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 16),
                const AppointmentRowInfo(
                  label: 'File number',
                  value: '',
                  //  appointment.fileNumber,
                ),
                const SizedBox(height: 8),
                const AppointmentRowInfo(label: 'Birth date', value: ''),
                const SizedBox(height: 8),
                const AppointmentRowInfo(
                  label: 'Report date',
                  value: '',
                  //  appointment.reportDate,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Diagnosis Card
          AppointmentCardInfo(
            title: 'Diagnosis',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '',
                  // appointment.diagnosis,
                  style: TextStyles.public.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 12),
                const Text(
                  '',
                  // appointment.diagnosisDescription,
                  style: TextStyles.notes,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Prescribed Medication Card
          AppointmentCardInfo(
            title: 'Prescribed medication',
            child: Column(
              children:
              // appointment.medications.map((medication) {
              //   return
              [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    children: [
                      // Medicine Icon
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF4ECDC4),
                        ),
                        child: Image.asset(
                          Assets.imagesIconsPill,
                          width: 24,
                          height: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Medicine Name
                      const Expanded(
                        child: Text(
                          '',
                          // medication.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              // }).toList(),
            ),
          ),

          const SizedBox(height: 32),

          // Doctor Name
          const Center(
            child: Text(
              '',
              // appointment.doctorName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A7A7C),
              ),
            ),
          ),

          const SizedBox(height: 24),

          RatingBarIndicator(
            rating: 4,
            itemBuilder:
                (context, _) => const Icon(Icons.star, color: Colors.amber),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),

          // Rating Section
          // Center(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       // Stars
          //       Row(
          //         children: List.generate(5, (index) {
          //           return Icon(
          //             index < appointment.rating
          //                 ? Icons.star
          //                 : Icons.star_border,
          //             color:
          //                 index < appointment.rating
          //                     ? Colors.amber
          //                     : Colors.grey[300],
          //             size: 32,
          //           );
          //         }),
          //       ),
          //       const SizedBox(width: 16),
          //       // Rate Button
          //       ElevatedButton(
          //         onPressed: () {
          //           // Handle rating action
          //         },
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: const Color(0xFF4CAF50),
          //           foregroundColor: Colors.white,
          //           padding: const EdgeInsets.symmetric(
          //             horizontal: 24,
          //             vertical: 12,
          //           ),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(20),
          //           ),
          //         ),
          //         child: const Text(
          //           'Rate',
          //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
