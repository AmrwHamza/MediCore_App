class AnalyseSymptomsEntity {
  final String message;
  final String suggestedDepartment;
  final int suggestedDepartmentId;
  final List<dynamic> symptomsProvided;

  AnalyseSymptomsEntity({
    required this.message,
    required this.suggestedDepartment,
    required this.suggestedDepartmentId,
    required this.symptomsProvided,
  });
}
