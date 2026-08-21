import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/appointments/data/models/appointment_types.dart';
import 'package:medicore_app/features/appointments/domain/entities/patient_appointment_entity.dart';
import 'package:medicore_app/features/appointments/presentation/view/appointments_view.dart';
import 'package:medicore_app/features/appointments/presentation/view_model/appointments_tab_cubit/appointments_tab_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/book_appointment_view.dart';
import 'package:medicore_app/features/main_home/presentation/view_model/nav_cubit/bottom_nav_cubit.dart';

class NextAppointmentBanner extends StatelessWidget {
  final PatientAppointmentEntity? nextAppointment;

  const NextAppointmentBanner({super.key, this.nextAppointment});

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  String _formatTime(DateTime date) {
    final hh = date.hour.toString().padLeft(2, '0');
    final mm = date.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  Color _statusColor(AppointmentTypes status) {
    switch (status) {
      case AppointmentTypes.pending:
        return KWarning;
      case AppointmentTypes.accepted:
        return KSuccess;
      case AppointmentTypes.incomplete:
        return KOrange;
      case AppointmentTypes.complete:
        return KInfo;
    }
  }

  void _openAppointmentsAccepted(BuildContext context) {
    BottomNavCubit? navCubit;
    try {
      navCubit = context.read<BottomNavCubit>();
    } catch (_) {
      navCubit = null;
    }

    if (navCubit != null) {
      navCubit.changeIndex(3);
      context.read<AppointmentsTabCubit>().openTab(AppointmentsTabCubit.accepted);
      return;
    }

    context.push(
      AppointmentsView.routeName,
      extra: {'tab': AppointmentsTabCubit.accepted},
    );
  }

  @override
  Widget build(BuildContext context) {
    final next = nextAppointment;
    if (next == null) return _buildEmpty(context);
    return _buildUpcoming(context, next);
  }

  Widget _buildEmpty(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? KCardDark : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isDark ? KBorderDark : Colors.grey.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          _LeadingIcon(
            icon: Icons.event_note_rounded,
            color: KPrimaryColor,
            isDark: isDark,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'no_upcoming_appointments'.tr(),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : KBlack,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'no_upcoming_appointments_desc'.tr(),
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.6)
                        : Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => context.push(BookAppointmentView.routeName),
            style: ElevatedButton.styleFrom(
              backgroundColor: KPrimaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              'book_now'.tr(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcoming(BuildContext context, PatientAppointmentEntity next) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;
    final doctorName = next.appointmentInfo.doctorName;
    final statusLabel = fromAppointmentTypesToString(next.status);
    final statusColor = _statusColor(next.status);
    final isRtl = Directionality.of(context).name == 'rtl';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _openAppointmentsAccepted(context),
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          decoration: BoxDecoration(
            color: isDark ? KCardDark : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: isDark ? KBorderDark : Colors.grey.withValues(alpha: 0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _LeadingIcon(
                icon: Icons.event_available_rounded,
                color: KPrimaryColor,
                isDark: isDark,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'next_appointment'.tr(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.6)
                                  : Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _StatusChip(
                          label: statusLabel,
                          color: statusColor,
                          isDark: isDark,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      doctorName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : KBlack,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 14,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _MetaItem(
                          icon: Icons.calendar_today_rounded,
                          text: _formatDate(next.appointmentDate),
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.7)
                              : Colors.grey[700]!,
                        ),
                        _MetaItem(
                          icon: Icons.schedule_rounded,
                          text: _formatTime(next.appointmentDate),
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.7)
                              : Colors.grey[700]!,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: KPrimaryColor.withValues(alpha: isDark ? 0.18 : 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isRtl
                      ? Icons.arrow_back_ios_new_rounded
                      : Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: KPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool isDark;

  const _LeadingIcon({
    required this.icon,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.18 : 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Icon(icon, color: color, size: 26),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool isDark;

  const _StatusChip({
    required this.label,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.18 : 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : color,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _MetaItem({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: KPrimaryColor, size: 13),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyles.notes.copyWith(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
