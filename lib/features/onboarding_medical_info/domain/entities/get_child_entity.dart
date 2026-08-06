class GetChildEntity {
  final int id;
  final int patientId;
  final String firstName;
  final String lastName;
  final String gender;
  final int age;
  final String birthDate;
  final String? bloodType;

  GetChildEntity({
    required this.id,
    required this.patientId,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.age,
    required this.birthDate,
    this.bloodType,
  });

  factory GetChildEntity.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> source = _flattenNestedChild(json);

    String pick(String key) {
      final value = source[key];
      if (value == null) return '';
      final text = value.toString().trim();
      if (text.isEmpty || text.toLowerCase() == 'null') return '';
      return text;
    }

    return GetChildEntity(
      id: _toInt(pick('id')),
      patientId: _toInt(pick('patient_id')),
      firstName: pick('first_name'),
      lastName: pick('last_name'),
      gender: pick('gender').isEmpty ? pick('sex') : pick('gender'),
      age: _toInt(pick('age')),
      birthDate: pick('birth_date'),
      bloodType: pick('blood_type').isEmpty ? null : pick('blood_type'),
    );
  }

  /// Flattens the various API shapes into one map. Supports direct keys,
  /// `{ "data": {...} }`, `{ "sons": {...} }`, `{ "child": {...} }` and
  /// `patient_info` sub-objects (with direct keys taking precedence).
  static Map<String, dynamic> _flattenNestedChild(Map<String, dynamic> json) {
    final extraSections = <String>['patient_info', 'sons', 'child'];

    final merged = <String, dynamic>{};
    for (final section in extraSections) {
      final value = json[section];
      if (value is Map) {
        merged.addAll(Map<String, dynamic>.from(value));
      }
    }
    // Nested `data` wrapper (API response body).
    if (json['data'] is Map) {
      final data = Map<String, dynamic>.from(json['data'] as Map);
      merged..addAll(data);
      for (final section in extraSections) {
        final value = data[section];
        if (value is Map) {
          merged.addAll(Map<String, dynamic>.from(value));
        }
      }
    }
    merged.addAll(json);
    return merged;
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    final parsed = int.tryParse(value?.toString() ?? '');
    return parsed ?? 0;
  }
}
