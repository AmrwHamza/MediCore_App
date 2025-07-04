import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/notification/presentation/view/widgets/notification_view_body.dart';

class NotificationView extends StatelessWidget {
  static const routeName = '/notification';
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getIt<ThemeProvider>().themeData.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: 'Notifications'.tr(), isMainBar: false),
      body: const NotificationViewBody(),
    );
  }
}
