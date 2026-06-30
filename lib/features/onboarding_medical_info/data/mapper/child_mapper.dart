import '../../domain/entities/child_entity.dart';
import '../../domain/entities/get_child_entity.dart';

class ChildMapper {
  static GetChildEntity fromChildEntityToGetGetChildEntity(ChildEntity entity) {
    return GetChildEntity(
      id: entity.id,
      patientId: int.parse(entity.patientId),
      firstName: entity.firstName,
      lastName: entity.lastName,
      gender: entity.gender,
      age: entity.age,
      birthDate: '',
    );
  }
}
