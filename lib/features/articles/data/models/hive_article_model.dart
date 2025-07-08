import 'package:hive/hive.dart';

part 'hive_article_model.g.dart';

@HiveType(typeId: 3)
class HiveArticleModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int doctorId;

  @HiveField(2)
  String title;

  @HiveField(3)
  String body;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime updatedAt;

  @HiveField(6)
  bool isFav;

  HiveArticleModel({
    required this.id,
    required this.doctorId,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    required this.isFav,
  });
}
