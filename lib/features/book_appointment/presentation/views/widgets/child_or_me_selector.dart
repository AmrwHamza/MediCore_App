import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/family/presentation/view_model/family_cubit/family_cubit.dart';

import '../../../../onboarding_medical_info/presentation/view/widgets/child_card.dart';
import '../../view_model/book_cubit/book_appointment_cubit.dart';

class ChildOrMeSelector extends StatefulWidget {
  const ChildOrMeSelector({super.key});

  @override
  State<ChildOrMeSelector> createState() => _ChildOrMeSelectorState();
}

class _ChildOrMeSelectorState extends State<ChildOrMeSelector> {
  String _selectedType = 'me';
  int? _selectedChildId;

  @override
  void initState() {
    super.initState();
    context.read<FamilyCubit>().getChilds();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'appointment_for'.tr(),
          style: TextStyle(
            color: theme.canvasColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildSelectorOption(
                id: 'me',
                title: 'myself'.tr(),
                icon: Icons.person_rounded,
                isSelected: _selectedType == 'me',
                theme: theme,
                isDark: isDark,
                onTap: () {
                  setState(() {
                    _selectedType = 'me';
                    _selectedChildId = null;
                  });
                  context.read<BookAppointmentCubit>().setSelectedSonId(null);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSelectorOption(
                id: 'child',
                title: 'my_child'.tr(),
                icon: Icons.child_care_rounded,
                isSelected: _selectedType == 'child',
                theme: theme,
                isDark: isDark,
                onTap: () {
                  setState(() {
                    _selectedType = 'child';
                  });
                  context.read<BookAppointmentCubit>().setSelectedSonId(
                    _selectedChildId,
                  );
                },
              ),
            ),
          ],
        ),
        if (_selectedType == 'child') ...[
          const SizedBox(height: 20),
          Text(
            'select_child'.tr(),
            style: TextStyle(
              color: theme.canvasColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 190,
            child: BlocBuilder<FamilyCubit, FamilyState>(
              builder: (context, state) {
                if (state is GetFamilyLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: KPrimaryColor),
                  );
                } else if (state is GetFamilyFailure) {
                  return Center(
                    child: Text(
                      state.error,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  );
                } else if (state is GetFamilySuccess &&
                    state.children.childList.isNotEmpty) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.children.childList.length,
                    itemBuilder: (context, index) {
                      final child = state.children.childList[index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: ChildCard(
                          child: child,
                          isSelected: _selectedChildId == child.id,
                          onTap: () {
                            setState(() {
                              _selectedChildId = child.id;
                            });
                            context
                                .read<BookAppointmentCubit>()
                                .setSelectedSonId(child.id);
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      'no_children_found'.tr(),
                      style: const TextStyle(
                        color: Color(0xff7C8283),
                        fontSize: 13,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSelectorOption({
    required String id,
    required String title,
    required IconData icon,
    required bool isSelected,
    required ThemeData theme,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: Material(
        color:
            isSelected
                ? (isDark
                    ? KPrimaryColor.withAlpha(40)
                    : KPrimaryColor.withAlpha(25))
                : theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color:
                    isSelected
                        ? KPrimaryColor
                        : theme.shadowColor.withAlpha(20),
                width: 2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color:
                      isSelected
                          ? KPrimaryColor
                          : (isDark ? Colors.white60 : Colors.black54),
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? KPrimaryColor : theme.canvasColor,
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
