import 'package:medicore_app/features/onboarding_medical_info/domain/entities/get_child_entity.dart';

class ChildsEntity {
  final String message;
  final List<GetChildEntity> childList;

  ChildsEntity({required this.message, required this.childList});
}
