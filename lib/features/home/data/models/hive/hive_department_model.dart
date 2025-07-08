import 'package:hive/hive.dart';
import 'package:medicore_app/features/home/domain/entities/department_entity.dart';

part 'hive_department_model.g.dart';

@HiveType(typeId: 1)
class HiveDepartmentModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  String image;

  HiveDepartmentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });
}

HiveDepartmentModel mapEntityToHiveModel(DepartmentEntity entity) {
  return HiveDepartmentModel(
    id: entity.id,
    name: entity.departmentName,
    description: entity.description,
    image: entity.image,
  );
}

Future<void> storeDepartmentsInHive(List<DepartmentEntity> departments) async {
  final box = Hive.box<HiveDepartmentModel>('departments');
  await box.clear();

  // تخزين الجديد
  for (var department in departments) {
    final hiveModel = mapEntityToHiveModel(department);
    await box.put(hiveModel.id, hiveModel);
  }
}
