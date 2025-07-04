import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/widget/custom_button.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/symptom_analysis_cubit/symptom_analysis_cubit.dart';

class SymptomBottomSheet extends StatelessWidget {
  const SymptomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SymptomAnalysisCubit>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          TextField(
            onChanged: cubit.searchOfSymptoms,
            decoration: InputDecoration(
              hintText: 'search_symptom'.tr(),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          BlocBuilder<SymptomAnalysisCubit, SymptomAnalysisState>(
            builder: (context, state) {
              final filteredSymptoms = cubit.filteredSymptoms;
              final selectedSymptoms = cubit.selectedSymptoms;
              return Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredSymptoms.length,
                  itemBuilder: (context, index) {
                    final name = filteredSymptoms[index].symptomName;
                    final isSelected = selectedSymptoms.contains(name);

                    return CheckboxListTile(
                      activeColor: KOrange,
                      value: isSelected,
                      title: Text(name),
                      onChanged: (_) => cubit.selectSymptom(name),
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          CustomButton(
            title: 'confirm'.tr(),
            onTap: () {
              // cubit.analyseSymptoms();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
