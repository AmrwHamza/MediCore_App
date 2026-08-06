import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/articles/presentation/view/articles_view.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/book_appointment_view.dart';
import 'package:medicore_app/features/departments/presentation/views/departments_view.dart';
import 'package:medicore_app/features/doctors/presentation/views/doctors_view.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    final actions = [
      _ActionData(
        icon: Icons.calendar_month_rounded,
        labelKey: 'action_book_appointment',
        onTap: () => context.push(BookAppointmentView.routeName),
      ),
      _ActionData(
        icon: Icons.category_rounded,
        labelKey: 'action_departments',
        onTap: () => context.push(DepartmentsView.routeName),
      ),
      _ActionData(
        icon: Icons.medical_services_rounded,
        labelKey: 'action_doctors',
        onTap: () => context.push(DoctorsView.routeName),
      ),
      _ActionData(
        icon: Icons.article_rounded,
        labelKey: 'action_articles',
        onTap: () => context.push(ArticlesView.routeName),
      ),
    ];

    return Row(
      children: List.generate(actions.length, (index) {
        final action = actions[index];
        return Expanded(
          child: _QuickActionItem(
            data: action,
            isDark: isDark,
          ),
        );
      }),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final _ActionData data;
  final bool isDark;

  const _QuickActionItem({required this.data, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: data.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: KPrimaryColor.withValues(
                  alpha: isDark ? 0.18 : 0.1,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: KPrimaryColor.withValues(alpha: 0.2),
                ),
              ),
              child: Icon(data.icon, color: KPrimaryColor, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              data.labelKey.tr(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.8)
                    : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionData {
  final IconData icon;
  final String labelKey;
  final VoidCallback onTap;

  const _ActionData({
    required this.icon,
    required this.labelKey,
    required this.onTap,
  });
}
