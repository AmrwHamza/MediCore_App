import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/family/presentation/view/widgets/child_header_section.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/get_child_entity.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ChildDetailsView extends StatelessWidget {
  static const routeName = '/childDetails';

  ChildDetailsView({Key? key, required this.child}) : super(key: key);

  final GetChildEntity child;

  final items = [
    {'date': '01/01/2025', 'doctor': 'Dr. Amr Hamza'},
    {'date': '16/05/2025', 'doctor': 'Dr. Amr Hamza'},
    {'date': '16/05/2025', 'doctor': 'Dr. Amr Hamza'},
    {'date': '16/05/2025', 'doctor': 'Dr. Amr Hamza'},
    {'date': '16/05/2025', 'doctor': 'Dr. Amr Hamza'},
    {'date': '16/05/2025', 'doctor': 'Dr. Amr Hamza'},
    {'date': '16/05/2025', 'doctor': 'Dr. Amr Hamza'},
    {'date': '16/05/2025', 'doctor': 'Dr. Amr Hamza'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;

    return Scaffold(
      appBar: CustomAppBar(
        title: '${child.firstName}' + 'profile_title'.tr(),
        isMainBar: false,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          ChildHeaderSection(child: child),
          Expanded(
            child: ListView.builder(
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
                    width: 12,
                    color: KPurple,
                    padding: EdgeInsets.all(6),
                  ),
                  beforeLineStyle: LineStyle(
                    color: theme.splashColor,
                    thickness: 3,
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.canvasColor.withAlpha(
                            (255 * 0.2).round(),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            item['date'] ?? '',
                            style: TextStyles.public.copyWith(
                              color: theme.canvasColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.medical_services,
                                size: 18,
                                color: theme.splashColor,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  item['doctor'] ?? '',
                                  style: TextStyles.public.copyWith(
                                    color: theme.canvasColor,
                                    fontSize: 13,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  startChild: const SizedBox.shrink(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
