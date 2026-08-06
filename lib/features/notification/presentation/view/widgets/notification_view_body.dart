import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_scroll_widget.dart';
import 'package:medicore_app/features/notification/domain/entities/notification_entity.dart';
import 'package:medicore_app/features/notification/presentation/view/widgets/notification_card.dart';
import 'package:medicore_app/features/notification/presentation/view_model/notification_cubit/notification_cubit.dart';
import 'package:medicore_app/features/notification/presentation/view_model/notification_cubit/notification_state.dart';

class NotificationViewBody extends StatefulWidget {
  const NotificationViewBody({super.key});

  @override
  State<NotificationViewBody> createState() => _NotificationViewBodyState();
}

class _NotificationViewBodyState extends State<NotificationViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().getNotifications();
  }

  Future<void> _refresh() async {
    await context.read<NotificationCubit>().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollWidget(
      color: KDarkBlue,
      onRefresh: _refresh,
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(
              child: CircularProgressIndicator(color: KPrimaryColor),
            );
          } else if (state is NotificationFailure) {
            return _EmptyState(message: state.error);
          } else if (state is NotificationSuccess) {
            final notifications = state.notifications;
            if (notifications.isEmpty) {
              return _EmptyState(message: 'no_notifications'.tr());
            }
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationCard(
                  title: _notificationTitle(notification),
                  subTitle: notification.message,
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  String _notificationTitle(NotificationEntity notification) {
    if (notification.message.isEmpty) {
      return 'Notifications'.tr();
    }
    final type = notification.type.split('\\').last;
    return type.isNotEmpty ? type : 'Notifications'.tr();
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: constraints.maxHeight,
            child: Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.canvasColor.withValues(alpha: 0.6),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
