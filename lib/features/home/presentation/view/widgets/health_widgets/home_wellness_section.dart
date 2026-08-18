import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/appointments/domain/entities/patient_appointment_entity.dart';
import 'package:medicore_app/features/appointments/presentation/view_model/appointments_cubit/appointments_cubit.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/home_skeletons.dart';
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
        if (state is AppointmentsLoading || state is AppointmentsInitial) {
          return const WellnessSectionSkeleton();
        }

        if (state is AppointmentsFailure) {
          return _WellnessErrorCard(
            message: state.error,
            onRetry: () => context.read<AppointmentsCubit>().getAppointments(),
          );
        }

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

class _WellnessErrorCard extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _WellnessErrorCard({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            isDark
                ? KCardDark.withValues(alpha: 0.4)
                : Colors.red.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: KOrange.withValues(alpha: 0.25),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: KOrange.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.error_outline_rounded,
              color: KOrange,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'error'.tr(),
                  style: TextStyles.public.copyWith(
                    color: KOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: TextStyles.notes.copyWith(
                    fontSize: 11,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: KOrange,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 9,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'retry'.tr(),
              style: TextStyles.button.copyWith(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
