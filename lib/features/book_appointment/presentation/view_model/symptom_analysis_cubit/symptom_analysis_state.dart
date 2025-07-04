part of 'symptom_analysis_cubit.dart';

abstract class SymptomAnalysisState extends Equatable {
  const SymptomAnalysisState();

  @override
  List<Object?> get props => [];
}

class SymptomAnalysisInitial extends SymptomAnalysisState {}

class SymptomSelectionChanged extends SymptomAnalysisState {
  final List<String> selectedSymptoms;
  const SymptomSelectionChanged(this.selectedSymptoms);

  @override
  List<Object?> get props => [selectedSymptoms];
}

class SymptomAnalysisLoading extends SymptomAnalysisState {}

class SymptomAnalysisSuccess extends SymptomAnalysisState {
  final int departmentId;
  final String message;

  const SymptomAnalysisSuccess({
    required this.departmentId,
    required this.message,
  });

  @override
  List<Object?> get props => [departmentId];
}

class SymptomAnalysisFailure extends SymptomAnalysisState {
  final String message;
  const SymptomAnalysisFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class GetSymptomsSuccess extends SymptomAnalysisState {
  final List<SymptomEntity> symptoms;
  const GetSymptomsSuccess({required this.symptoms});
}

class GetSymptomsFailure extends SymptomAnalysisState {
  final String message;
  const GetSymptomsFailure({required this.message});
}

class GetSymptomsLoading extends SymptomAnalysisState {}
