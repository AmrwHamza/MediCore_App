import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/features/appointments/domain/entities/patient_appointment_entity.dart';
import 'package:medicore_app/features/appointments/presentation/view_model/appointments_cubit/appointments_cubit.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/health_widgets/next_appointment_banner.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/health_widgets/smart_wellness_mood_card.dart';

/// Composes the SmartWellnessMoodCard and the NextAppointmentBanner using a
/// single source of appointment data from the shared [AppointmentsCubit].
class HomeWellnessSection extends StatefulWidget {
  const HomeWellnessSection({super.key});

  @override
  State<HomeWellnessSection> createState() => _HomeWellnessSectionState();
}

class _HomeWellnessSectionState extends State<HomeWellnessSection> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AppointmentsCubit>();
    if (cubit.state is! AppointmentsSuccess) {
      cubit.getAppointments();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsCubit, AppointmentsState>(
      builder: (context, state) {
        if (state is! AppointmentsSuccess) {
          return const SizedBox.shrink();
        }

        final upcoming = <PatientAppointmentEntity>[
          ...state.waitingPatient,
          ...state.acceptedPatient,
        ];
        upcoming.sort(
          (a, b) => a.appointmentDate.compareTo(b.appointmentDate),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SmartWellnessMoodCard(
              upcomingAppointments: upcoming.length,
              completedAppointments: 0,
            ),
            const SizedBox(height: 16),
            NextAppointmentBanner(
              nextAppointment: upcoming.isEmpty ? null : upcoming.first,
            ),
          ],
        );
      },
    );
  }
}