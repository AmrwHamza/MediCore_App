import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/family/presentation/view/widgets/child_header_section.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/get_child_entity.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ChildDetailsView extends StatelessWidget {
  static const routeName = '/childDetails';

  ChildDetailsView({super.key, required this.child});

  final GetChildEntity child;

  final items = [
    {'date': '01/01/2025', 'doctor': 'Dr. Amr Hamza'},
    {'date': '16/05/2025', 'doctor': 'Dr. Amr Hamza'},
    {'date': '16/05/2025', 'doctor': 'Dr. Amr Hamza'},
    {'date': '16/05/2025', 'doctor': 'Dr. Amr Hamza'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return Scaffold(
      appBar: CustomAppBar(
        title: '${child.firstName} ${_getProfileTitleSuffix()}',
        isMainBar: false,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          ChildHeaderSection(child: child),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isFirst = index == 0;
                final isLast = index == items.length - 1;

                return TimelineTile(
                  alignment: TimelineAlign.center,
                  isFirst: isFirst,
                  isLast: isLast,
                  indicatorStyle: const IndicatorStyle(
                    width: 14,
                    color: KPurple,
                    padding: EdgeInsets.all(4),
                  ),
                  beforeLineStyle: LineStyle(
                    color: theme.dividerColor,
                    thickness: 2,
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.canvasColor.withAlpha(
                            (255 * 0.1).round(),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['date'] ?? '',
                            style: TextStyles.public.copyWith(
                              color: theme.canvasColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.medical_services,
                                size: 16,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  item['doctor'] ?? '',
                                  style: TextStyles.public.copyWith(
                                    color: theme.canvasColor.withAlpha(200),
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static String _getProfileTitleSuffix() {
    try {
      return 'profile_title'.tr();
    } catch (_) {
      return " Profile";
    }
  }
}
