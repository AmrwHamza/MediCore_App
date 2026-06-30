import '../../../onboarding_medical_info/domain/entities/child_entity.dart';
import '../../../onboarding_medical_info/domain/entities/get_child_entity.dart';

ChildEntity fromGetChildEntity(GetChildEntity getChildEntity) {
  return ChildEntity(
    message: '',
    id: getChildEntity.id,
    patientId: getChildEntity.patientId.toString(),
    firstName: getChildEntity.firstName,
    lastName: getChildEntity.lastName,
    gender: getChildEntity.gender,
    age: getChildEntity.age,
  );
}

GetChildEntity toGetChildEntity(ChildEntity childEntity) {
  return GetChildEntity(
    id: childEntity.id,
    patientId: int.parse(childEntity.patientId),
    firstName: childEntity.firstName,
    lastName: childEntity.lastName,
    gender: childEntity.gender,
    age: childEntity.age,
    birthDate: '',
  );
}
