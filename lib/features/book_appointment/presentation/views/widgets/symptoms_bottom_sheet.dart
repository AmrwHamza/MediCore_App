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
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 25,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 45,
            height: 5,
            decoration: BoxDecoration(
              color: theme.disabledColor.withAlpha(80),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            onChanged: cubit.searchOfSymptoms,
            style: TextStyle(color: theme.canvasColor),
            decoration: InputDecoration(
              hintText: 'search_symptom'.tr(),
              hintStyle: TextStyle(color: theme.disabledColor),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: theme.disabledColor,
              ),
              filled: true,
              fillColor: theme.cardColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color:
                      isDark ? Colors.white12 : theme.shadowColor.withAlpha(15),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: KPrimaryColor, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.45,
              ),
              child: BlocBuilder<SymptomAnalysisCubit, SymptomAnalysisState>(
                builder: (context, state) {
                  final filteredSymptoms = cubit.filteredSymptoms;
                  final selectedSymptoms = cubit.selectedSymptoms;

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredSymptoms.length,
                    separatorBuilder:
                        (_, __) => Divider(
                          color:
                              isDark
                                  ? Colors.white10
                                  : theme.shadowColor.withAlpha(10),
                          height: 1,
                        ),
                    itemBuilder: (context, index) {
                      final name = filteredSymptoms[index].symptomName;
                      final isSelected = selectedSymptoms.contains(name);

                      return CheckboxListTile(
                        activeColor: KOrange,
                        checkColor: Colors.white,
                        value: isSelected,
                        title: Text(
                          name,
                          style: TextStyle(
                            color: theme.canvasColor,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onChanged: (_) => cubit.selectSymptom(name),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
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
