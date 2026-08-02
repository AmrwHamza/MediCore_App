import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/symptom_analysis_cubit/symptom_analysis_cubit.dart';

class SymptomBottomSheet extends StatelessWidget {
  const SymptomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SymptomAnalysisCubit>();
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.15),
            blurRadius: 30,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        14,
        20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: theme.disabledColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 24),

          TextField(
            onChanged: cubit.searchOfSymptoms,
            style: TextStyle(color: theme.canvasColor, fontSize: 15),
            decoration: InputDecoration(
              hintText: 'search_symptom'.tr(),
              hintStyle: TextStyle(
                color: theme.disabledColor.withValues(alpha: 0.7),
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: KPrimaryColor.withValues(alpha: 0.7),
                size: 22,
              ),
              filled: true,
              fillColor: theme.cardColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color:
                      isDark
                          ? Colors.white12
                          : theme.shadowColor.withValues(alpha: 0.05),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: KPrimaryColor, width: 1.8),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.45,
              ),
              child: BlocBuilder<SymptomAnalysisCubit, SymptomAnalysisState>(
                builder: (context, state) {
                  final filteredSymptoms = cubit.filteredSymptoms;
                  final selectedSymptoms = cubit.selectedSymptoms;

                  if (filteredSymptoms.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            color: theme.disabledColor,
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'لا توجد نتائج مطابقة لعرضك الحالي',
                            style: TextStyle(
                              color: theme.disabledColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredSymptoms.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final name = filteredSymptoms[index].symptomName;
                      final isSelected = selectedSymptoms.contains(name);

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? KPrimaryColor.withValues(alpha: 0.06)
                                  : theme.cardColor,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color:
                                isSelected
                                    ? KPrimaryColor.withValues(alpha: 0.3)
                                    : Colors.transparent,
                            width: 1,
                          ),
                        ),
                        child: CheckboxListTile(
                          activeColor: KPrimaryColor,
                          checkColor: Colors.white,
                          value: isSelected,
                          title: Text(
                            name,
                            style: TextStyle(
                              color:
                                  isSelected
                                      ? KPrimaryColor
                                      : theme.canvasColor,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                              fontSize: 14.5,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          onChanged: (_) => cubit.selectSymptom(name),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),

          CustomButton(
            title: 'confirm'.tr(),
            color: KPrimaryColor,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
